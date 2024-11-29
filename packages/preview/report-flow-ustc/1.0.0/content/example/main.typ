#import "@preview/report-flow-ustc:1.0.0": *

#show: project.with(
  course: "计算机系统",
  lab_name: "位运算实验",
  stu_name: "顶针",
  stu_num: "SA114514",
  major: "计算机科学与技术",
  department: "计算机科学与技术学院",
  date: (2024, 10, 1),
  show_content_figure: true,
  watermark: "USTC",
)
#show :show-cn-fakebold

#set text(size:9pt)

= 第一次作业

==

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
定理一：如果断言$P$是转移系统$S$的一个不变式，那么对$S$的每次执行的每一配置，$P$成立。

证明：$E$为$S$的一次执行$(r_0,r_1,dots)$，对于每个$i$，$P(r_i)$成立。

+ 首先，$r_0 #sym.in I$，由定义可得$P(r_0)$成立。
+ 假设$P(r_i)$成立，那么由转移系统的定义可得$P(r_(i+1))$成立。

由归纳法，成立，定理证毕。

*思考：*

是否对于每一执行的每一断言都成立的断言/性质就是不变式？（EX：给出一个转移系统S和断言P，满足P在S中总为真，但P不是S的不变式）
]



*解：*
配置集：${ A, B, C, D }$。初始配置：$A$

转移关系：
- $( A #sym.arrow B )$
- ( B #sym.arrow C )
- ( A #sym.arrow D ) （在正常执行中不会出现）
$P$：配置不为 $D$。

根据不变式的定义，$P$ 必须满足：
- 所有初始配置满足 $P$。
- 对于任意一个满足 $P$ 的配置，如果进行一次转移后到达新的配置，那么新的配置也必须满足 $P$。

1. 在所有执行的配置中 $P$ 成立

考虑 $S$ 的正常执行路径：
- 执行路径 1： $A #sym.arrow B #sym.arrow C$ 
- 执行路径 2： $A #sym.arrow B #sym.arrow C #sym.arrow dots$  （假设执行在 $C$ 终止）
   
在这些执行路径中，配置只会经历 $A$、$B$、和 $C$。$P$ 都成立，因为它们都不是 $D$。

2. 存在一个转移使得 $P$ 不成立

系统 $S$ 还定义了一个转移 ( A #sym.arrow D )。如果这个转移被执行，配置将变为 $D$，此时 $P$ 不成立。


因此即使一个断言在所有执行路径的配置中始终为真，它也可能不是不变式。



= 第二次作业

==

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
  为何从根能到达每一结点？(连通)反证：假设某结点在G中从pr不可达，因网络是连通的，若存在两个相邻的结点pi和pj使得pj在G中是从pr可达的(以下简称pj可达)，但pi不可达。因为_G里一结点从pr可达当且仅当它曾设置过自己的parent变量(Ex 证明)_，所以pi的parent变量在整个执行中仍为nil，而pj在某点上已设置过自己的parent变量，于是pj发送M到pi(line9)，因该执行是容许的，此msg必定最终被pi接收，使pi将自己的parent变量设置为j。矛盾！
]

*证明*：在图 $G$ 中，一个结点 $A$ 从根节点 $P r$ 可达，当且仅当 $A$ 已经设置过自己的 `parent` 变量。



1. *必要性*：如果结点 $A$ 从 $P r$ 可达，则 $A$ 已经设置过自己的 `parent` 变量。
2. *充分性*：如果结点 $A$ 已经设置过自己的 `parent` 变量，则 $A$ 从 $P r$ 可达。



（1）必要性：从 $P r$ 可达 ⇒ 设置过 `parent` 变量

*目标*：证明如果结点 $A$ 在图 $G$ 中从 $P r$ 可达，则 $A$ 已经为其 `parent` 变量赋值。

数学归纳法


1. *基例*（跳数为 0，即 $A$ 为根节点 $P r$）：
   - 当 $A = P r$ 时，按照算法的第 4 行，$A$ 给自己的 `parent` 变量赋值。因此，基例成立。
2. *归纳假设*：
   - 假设对于跳数小于 $n$ 的所有结点，若它们从 $P r$ 可达，则它们已经设置过自己的 `parent` 变量。
3. *归纳步骤*（跳数为 $n$ 的结点 $A$）：
   - 由于 $A$ 从 $P r$ 可达，存在一条从 $P r$ 到 $A$ 的最短路径，跳数为 $n$。
   - 该路径的倒数第二个结点 $B$ 的跳数为 $n-1$，根据归纳假设，$B$ 已经设置过自己的 `parent` 变量。
   - 根据算法的第 9 行，$B$ 会向其所有邻居发送消息，其中包括 $A$。
   - 由于执行是容许的，$A$ 最终会接收到来自 $B$ 的消息，并在算法的第 7 行设置自己的 `parent` 变量为 $B$。
   - 因此，结点 $A$ 已经设置过自己的 `parent` 变量。




（2）充分性：设置过 `parent` 变量 ⇒ 从 $P r$ 可达

*目标*：证明如果结点 $A$ 已经设置过自己的 `parent` 变量，则 $A$ 从 $P r$ 可达。


1. *根节点情况*：
   - 当 $A = P r$ 时，显然 $P r$ 从自身可达。

2. *非根节点情况*：
   - 若 $A$ 不是根节点，则它是在算法的第 7 行设置了自己的 `parent` 变量。
   - 根据算法的容许执行特性，结点 $A$ 必然在第 5 行接收过消息 $M$。
   - 消息 $M$ 只能从 $P r$ 或已经从 $P r$ 可达的结点传递过来。
   - 因此，存在一条从 $P r$ 到 $A$ 的路径，使得 $A$ 从 $P r$ 可达。

*结论*：如果结点 $A$ 已经设置过自己的 `parent` 变量，则 $A$ 从 $P r$ 可达。



 
= 第三次作业

#figure(
```py
# Alg 2.3 构造DFS生成树，以 P_r 为根
# Code for processor P_i, 0 ≤ i ≤ n-1

var parent: init nil
    children: init ϕ
    unexplored: init all the neighbors of P_i  # 未访问过的邻居集

# Step 1: upon receiving no message:
if (i == r) and (parent == nil) then:
    # 当 P_i 为根且未发送 M 时
    parent := i  # 将 parent 置为自身的标号
    for each P_j ∈ unexplored:
        remove P_j from unexplored  # 若 P_j 是孤立结点，4-6应稍作修改
        send M to P_j
    end for

# Step 7: upon receiving M from neighbor P_j:
if parent == nil then:
    # P_i 此前未收到 M
    parent := j  # P_j 是 P_i 的父亲
    remove P_j from unexplored

if unexplored ≠ ϕ then:
    for each P_k ∈ unexplored:
        remove P_k from unexplored
        send M to P_k
    end for
else:
    send <parent> to parent  # 当 P_i 的邻居均已访问过，返回到父亲
end if
else:
    send <reject> to P_j  # 当 P_i 已访问过时

# Step 17: upon receiving <parent> or <reject> from neighbor P_j:
if received <parent> then:
    add j to children  # P_j 是 P_i 的孩子

if unexplored = ϕ then:
    if parent ≠ i then:
        send <parent> to parent  # P_i 非根，返回至双亲
    terminate  # 以 P_i 为根的 DFS 子树已构造好！
else:
    # 选择 P_i 的未访问过的邻居访问之
    for each P_k ∈ unexplored:
        remove P_k from unexplored
        send M to P_k
    end for
end if

```,
caption: [Alg. 2.3], supplement: none,
)

== 

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
2.1 分析在同步和异步模型下，convergecast算法的时间复杂性。

]

*1. 同步模型*

在同步模型中，Convergecast 算法通过生成树结构汇聚最大值。具体分析如下：

- *消息传递*：每个节点只需向其父节点发送一条消息，总共需要传递 $n-1$ 条消息。
- *轮次*：在最坏的情况下，当生成树退化为链表时，每一轮只能传递一条消息，因此需要进行 $n-1$ 轮。
- *时间复杂度*：综合上述因素，算法的时间复杂度为 $O(n - 1)$。

*2. 异步模型*

在异步模型下，Convergecast 算法的时间复杂性取决于消息传递的路径长度。具体分析如下：

- *路径长度*：每个节点收到消息的时间取决于其到最远叶子节点的路径长度。
- *最坏情况*：当生成树退化为链表时，路径长度为 $n-1$。
- *时间复杂度*：因此，算法的时间复杂度为 $O(n - 1)$。

综上所述，Convergecast 算法在同步和异步模型下的时间复杂性均为 $O(n - 1)$。

== 

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
2.3 证明Alg2.3构造一棵以Pr为根的DFS树。
]


1. *引理：Alg2.3执行过程中，图中恰有一条消息在传递。*

   *证明：*
   - *初始状态*：仅根节点 $P_r$ 发送一条消息。
   - *消息传递规则*：
     - 任意非根节点在收到一条消息后，恰好向一个邻居节点发送一条消息。
     - 根节点在收到消息时，要么继续发送消息给其未探索的邻居，要么终止算法。
由于每个节点在任意时刻最多只发送一条消息，且根节点在任何时刻也只发送一条消息，图中不可能同时存在多条消息在传递。因此，引理成立。

2. *Alg2.3的有穷性：Alg2.3必定能够终止。*

   *证明：*
   - *消息数量限制*：
     - 每个节点至多向其每个相邻节点发送一次M消息。
     - 每个节点至多向其相邻节点发送一条parent消息或reject消息。
     - 假设图中有 $m$ 条边，每条边两个方向最多各有两条消息，故总消息数不超过 $4m$。
   - *消息传递时间*：
     - 由引理知，最多有 $4m$ 条消息，每条消息的发送时间不超过 $t$，因此总发送时间不超过 $4t$。
由于消息总数有限，Alg2.3必定在有限时间内终止。

3. *生成的DFS树的正确性：*

   为了证明生成的是DFS树，需要验证以下三个性质：连通性、无环性和深度优先性。

   - *（1）连通性*

     *假设*：存在相邻的节点 $A$ 和 $B$，其中 $A$ 在DFS树中，$B$ 不在DFS树中。

     *分析*：
     - $B$ 初始时在 $A$ 的 `unexplored` 集合中。
     - 由于Alg2.3的有穷性，$A$ 会向其某个邻居 $C$ 发送M消息。
     - 根据算法，当 $A$ 向 $C$ 发送消息后，会收到相应的parent或reject消息，触发进一步的操作。
     - 若 $C=B$，则 $B$ 应该被加入DFS树，这与假设矛盾。
     - 因此，所有相邻节点最终都会被包含在DFS树中，保证了连通性。

   - *（2）无环性*

     *假设*：生成的DFS树中存在一个环 $P_1, P_2, dots, P_i, P_1$ 。

     *分析*：
     - 假设 $P_1$ 是环中最早接收到M消息的节点，并且首先将消息传递给 $P_2$。
     - 根据算法，$P_1$ 是 $P_2$ 的父节点，$P_2$ 是 $P_3$ 的父节点，依此类推，直到 $P_i$ 是 $P_1$ 的父节点。
     - 然而，这意味着 $P_i$ 必须向 $P_1$ 发送M消息，但 $P_1$ 已经是其父节点，不会接受来自 $P_i$ 的新的M消息，而是应发送reject消息。
     - 这与环的假设矛盾，因此生成的DFS树中不可能存在环。

   - *（3）深度优先性*

     *目标*：在子节点与兄弟节点都未访问时，先加入DFS树的一定是子节点。

     *证明*：
     - 由引理知，任意时刻只有一个节点是活跃的，且该节点仅向一个未访问的邻居发送消息。
     - 根据算法，节点会优先向未被探索的邻居（即子节点）发送消息，而不是向兄弟节点发送消息。
     - 因此，在子节点和兄弟节点都未访问时，子节点会优先被加入DFS树，满足深度优先性。


== 

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
2.4 证明Alg2.3的时间复杂性为O(m)。
]

我们将通过分析同步模型和异步模型下 Alg2.3 的消息传递过程，证明其时间复杂性均为 $O(m)$，其中 $m$ 是图中的边数。

 1. 同步模型

*分析过程：*

- *引理回顾*：根据之前的引理（证明 Alg2.3 构造 DFS 生成树的正确性部分），在算法执行过程中，每一轮中恰有一条消息在传输。
  
- *消息总数*：根据 Alg2.3 的有穷性证明，任意图中有 $m$ 条边，最多会发送 $4m$ 条消息（每条边两个方向，每个方向最多发送两条消息）。
  
- *时间复杂度*：
  - 在同步模型下，每一轮传输一条消息。
  - 总消息数为 $4m$ 条，因此总轮数为 $4m$ 轮。
  - 因此，算法的时间复杂度为 $O(4m) = O(m)$。

*结论*：在同步模型下，Alg2.3 的时间复杂性为 $O(m)$。

 2. 异步模型

*分析过程：*

- *消息传递特点*：在异步模型下，消息的传递时间不固定，但根据引理，任意时刻只有一条消息在传输。
  
- *消息总数*：同样，消息总数最多为 $4m$ 条。
  
- *时间复杂度*：
  - 由于异步模型下消息传递的顺序不确定，但由于任意时刻只有一条消息在传输，消息的总传递时间与消息数量成正比。
  - 因此，总时间复杂度仍为 $O(4m) = O(m)$。

*结论*：在异步模型下，Alg2.3 的时间复杂性同样为 $O(m)$。


== 

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
2.5 修改Alg2.3获得一新算法，使构造DFS树的时间复杂性为O(n)，并证明。
]

1. *消息类型的引入*：
   - 当节点 $A$ 向节点 $B$ 发送消息 $M$ 时，节点 $A$ 同时向除了其父节点和 $B$ 以外的所有邻居节点发送消息 $X$。

2. *维护消息 $X$ 的邻居集合*：
   - 每个节点维护一个集合，用于记录已经收到消息 $X$ 的邻居节点。
   - 在以后，节点不会向这些记录在集合中的邻居节点发送消息 $M$。

3. *消息传递的限制*：
   - 通过上述机制，消息 $M$ 仅在生成树的边上进行传递。
   - 具体来说，如果尝试通过非生成树的边传递消息 $M$，将导致逻辑上的矛盾，从而防止了消息 $M$ 在生成树以外的边上传递。

 *正确性证明*

1. *消息 $M$ 仅在生成树的边上传递*：
   - 假设消息 $M$ 通过非生成树的边 $ B arrow A$ 传递。
   - 在这种情况下，节点 $A$ 和 $B$ 已经在生成树中。
   - 由于 $ B arrow A$ 不属于生成树的边，说明 $A$ 不是 $B$ 的父节点，因此存在一个节点 $C$ 使得 $A$ 是 $C$ 的父节点。
   - 当 $A$ 向 $C$ 发送消息 $M$ 时，也会向 $B$ 发送消息 $X$。
   - 这意味着 $B$ 在时刻 $T$ 之前已经收到了来自 $A$ 的消息 $X$，因此在时刻 $T$ 向 $A$ 发送消息 $M$ 时，会与维护的邻居集合发生冲突，导致矛盾。
   - 因此，消息 $M$ 无法通过非生成树的边传递，确保了其仅在生成树的边上传递。

 *时间复杂性分析*

1. *消息复杂度*：
   - 由于每个节点在构造生成树时，只会通过生成树的边发送一次消息 $M$，且每条生成树的边只对应一次消息传递。
   - 因此，总消息数与节点数 $n$ 成线性关系，即消息复杂度为 $O(n)$。

2. *时间复杂度*：
   - 根据之前的分析，时间复杂度与消息复杂度一致。
   - 因此，算法的时间复杂度为 $O(n)$。



= 第四次作业

== 

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
Ex3.1 证明同步环系统中不存在匿名的、一致性的领导者选举算法。
]

证明同步环系统中不存在匿名且一致的领导者选举算法

*命题*：在匿名的同步环系统中，不存在既匿名又一致的领导者选举算法。

*证明方法*：采用数学归纳法，证明在每一轮中所有处理器的状态均相同，从而无法选出唯一的领导者。

1. *初始状态*：
   - 由于系统是匿名的，每个处理器的初始状态完全相同。

2. *归纳假设*：
   - 假设在第 $n$ 轮时，所有处理器的状态均相同。

3. *归纳步骤*：
   - *发送消息*：根据归纳假设，在第 $n$ 轮，每个处理器的状态相同，因此在第 $n+1$ 轮，各处理器发送的消息也相同。
   - *接收消息*：环形拓扑结构具有对称性，所有处理器在第 $n+1$ 轮接收到的消息相同。
   - *状态转移*：由于系统是匿名的，处理器在相同状态和相同消息的情况下，状态机的转移函数相同，因此所有处理器在第 $n+1$ 轮后的状态依然相同。

4. *结论*：
   - 通过归纳法，所有轮次中，所有处理器的状态始终保持一致。
   - 结果是，要么所有处理器同时成为领导者，要么所有处理器都不成为领导者。
   - 因此，不存在仅选出一个唯一领导者的算法。


== 

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
Ex3.2 证明异步环系统中不存在匿名的领导者选举算法。
]

 

= 第五次作业

==

#block(
    fill: rgb("#0000000f"),    
    radius: 10pt,
    inset: 1em,
    width: 100%,
)[
  若将环$R_n^(r e v)$划分为长度为j(j是2的方幂)的连续片断，则所有这些片断是序等价的
]

*问题：*  

*证明：*  
对于一个整数 #mi(`P(0 \leq P \leq n-1)`) ，可以表示为：

#mi(`P = \sum_{i=1}^{m} a_i \cdot 2^{i-1}`)

其中 #mi(`m = \log_2 n`)。其反序表示为 #mi(`rev(P) = \sum_{i=1}^{m} a_i \cdot 2^{m-i}`)。

设 #mi(`P`)、#mi(`Q`) 在同一个片段上，且 #mi(`P_1`)、#mi(`Q_1`) 也在同一个片段上，并且相邻。通过模运算的加法可得：#mi(`P_1 = P + 1`)，#mi(`Q_1 = Q + 1`)。片段的长度为 #mi(`2^k`)。

可以表示 #mi(`P`) 和 #mi(`Q`) 为：

#mi(`P = \sum_{i=1}^{m} a_i \cdot 2^{i-1}`)

#mi(`Q = \sum_{i=1}^{m} b_i \cdot 2^{i-1}`)

且 #mi(`P`)、#mi(`Q`) 在同一个片段上，有：

#mi(`|P - Q| < 2^k`)

因此存在某个 #mi(`r(0 \leq r \leq k)`) ，满足 #mi(`a_r \neq b_r`)，否则 #mi(`|P - Q| \geq 1`)。这与 #mi(`P`)、#mi(`Q`) 在同一个片段上相矛盾。

设 #mi(`s = \min\{j \mid a_j \neq b_j\}`)，则根据 #mi(`rev(P)`)、#mi(`rev(Q)`) 的表示法可得：

#mi(`\text{sign}(rev(P) - rev(Q)) = \text{sign}(a_s - b_s)`)

而：

#mi(`P_1 = P + 1 = \sum_{i=1}^{m} a_i \cdot 2^{i-1} + 2^k`)

#mi(`Q_1 = Q + 1 = \sum_{i=1}^{m} b_i \cdot 2^{i-1} + 2^k`)

显然，#mi(`P`) 与 #mi(`P_1`) 的前 #mi(`k`) 位相同，#mi(`Q`) 与 #mi(`Q_1`) 的前 #mi(`k`) 位也相同。由此可得：

#mi(`\text{sign}(rev(P_1) - rev(Q_1)) = \text{sign}(a_s - b_s)`)

这两个相邻片段是次序等价的。根据等价的传递关系，可得所有片段都是次序等价的。
