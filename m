Subject: Re: [RFC] An idea of thread/child-domain assignment
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <487C7698.60503@ak.jp.nec.com>
References: <487C7698.60503@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 09:38:04 -0400
Message-Id: <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-15 at 19:06 +0900, KaiGai Kohei wrote:
> Hi,
> 
> I'm now considering the way to apply SELinux from the bottom of LAPP
> stack to the head. But there is a fundamental matter. Web/Application
> server can execute a request come from users in a worker thread.
> 
> This idea enables to assign an indivisual domain on a thread under
> the paticular condition.

Yes, this came up recently, e.g.:
http://marc.info/?l=selinux&m=121320242220824&w=2

And James added it to the kernel todo list on selinuxproject.org.

> I'm sorry for a long description, but I thought it need to describe
> the background of this idea for well understanding.
> 
> Please comment anything.
> 
> Backend of the idea
> -------------------
> How do you define a user?
> 
> I consider a user is a human. In the most cases, a human is not good at
> communication with electronic circuit of computer system, so he makes a
> substitution of himself to obtain a result which he want.
> 
> A process on operating system is a typical substitution of the user.
> Thus, it has a user identifier and a security context for proper access
> controls as a substitution of a user.
> I'm considering database instances, web backends and others are also the
> substitution of users, because they works according to the request come
> from users.
> 
> SELinux makes its decison on access controls based on security context of
> subject and various kind of objects. Now we have three options to assign
> a security context on a subject, as follows:
> 
>  1. Authentication     ... Operating System
>  2. Labeled Networking ... SE-PostgreSQL, X/SELinux, Xinetd
>  3. Do nothing         ... Apache, Samba
> 
> However, the third option is uncomfortable for system security.
> It execute a user's request as a part of the server process, even if it
> is a substitution of the user.
> 
> 
> LAPP stack and SELinux
> ----------------------
> Nowaday, numerous of online services are available and most of them are
> implemented as a web application using PHP, Jservlet and so on. LAPP is
> a term to represent its system architecture. It shows web applications
> based on Linux, Apache, PostgreSQL and PHP is a popular combination.
> 
> >From the viewpoint of SELinux, we cannot apply inidividual access controls
> for every request come from clients, because web/application server handle
> these requests without individual processes (except for CGI invocation).
> Apache typically assigns a pre-created process/thread with "httpd_t" domain
> to execute the request, independent from the peer's context.
> 
> Now SELinux can cover the lowest two layer of the LAPP stack (OS, RDBMS).
> It enables to apply consistent/mandatory access controls for them. I think
> it should be also expanded to whole of the stack to improve web-application
> security.
> But we have a fundamental matter to achieve it.
> 
>  [1] LAPP Stack and SELinux coverage
>  +----------------------------+   <-----------------+
>  |  Application (PHP, Tomcat) |                     |
>  +----------------------------+                     |
>  |    Web Server (Apache)     |                  Future
>  +----------------------------+   <-----------+     |
>  |  Database (SE-PostgreSQL)  |               |     |
>  +----------------------------+   <-----+   Today   |
>  | Operating System (SELinux) |       Past    |     |
>  +----------------------------+   <-----+-----+-----+
> 
> 
> An idea: thread/hierarchical-domain assignment
> ----------------------------------------------
> If possible, Apache should change the security context of web backend
> during it executes a request come from users.
> However, Apache can execute it on a worker thread. It conflicts a wired
> constraint of SELinux which does not allow a multi-threaded process dynamic
> domain transition.
> 
> It is a reasonable constraint, if the source and destination domains are
> completely independent. Because it shares a local memory, mixed security
> context within a process can make a violation in domain separation.
> 
> However, a characteristic relationship between hierarchical domains can
> help the situation. It restricts a child domain (like "httpd_t.staff")
> cannot over the boundary of its parent ("httpd_t"). It also means
> a multi-threaded process cannot over the (parent) domain boundary,
> even if a part of threads has different security context.
> 
> My suggestion is the hard-wired constraint should be modified.
> It allows to assign threads an indivisual domain, if the new domain
> is a child one of the current domain.
> 
>   For example:
>     httpd_t -> httpd_t.staff           = allowed
>     httpd_t -> staff_t                 = disallowed
>     httpd_t.staff -> httpd_t.staff.php = allowed
> 
> In other words, this idea requires to change our viewpoint for child domain.
> Previously, these are mutually independent domain, but a child domain will
> mean a state with restricted operations compared to its parent domain.

I tend to agree that we should support such changes in the kernel
mechanism and let the use of it be determined by the policy.

In terms of hierarchy though, the plan was to replace the current
name-based hierarchy with an explicitly declared hierarchy.

> 
> Issues: Domain Reverting
> ------------------------
> There is a related issue. To change security context during user request
> execution also means that we have to revert its domain after executions,
> because Apache repeatedly uses worker thread/process for some reasons.
> 
> I don't have any good idea for this issue yet.
> A one time cookie like AppArmor is an approach, but it is basically weak
> separation compared from execve() transition.

Perhaps it could pre-populate different pools of threads for different
client security contexts, and then just draw from the correct pool for
each client.  Then the thread context doesn't have to be reverted at all
and we can make the transition unidirectional.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
