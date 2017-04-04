Message-ID: <1491323167.31785.14.camel@tycho.nsa.gov>
Subject: Re: Confining a Java process reading file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rahmadi Trimananda <rtrimana@uci.edu>, selinux@tycho.nsa.gov
Date: Tue, 04 Apr 2017 12:26:07 -0400
In-Reply-To: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
References: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda wrote:
> Hey Guys,
> 
> I am trying to confine a Java process that I have so that it will be
> able to read only certain files. This is my experiment setup for my
> folder. Basically a.out (C program) and Test.class (Java class) are
> coded to read and print out the text in test.txt.
> 
>     unconfined_u:object_r:httpd_t:SystemLow a.out
> unconfined_u:object_r:user_home_t:SystemLow test.c
>     unconfined_u:object_r:httpd_t:SystemLow Test.class
> unconfined_u:object_r:user_home_t:SystemLow Test.java
> unconfined_u:object_r:user_home_t:SystemLow test.txt
> 
> I tried to change the type label for a.out from user_home_t to
> httpd_t just for the sake of the experiment. With this setup, a.out
> is no longer able to read test.txt in enforcing mode. However, I seem
> to not be able to do it for Test.class as it's running on a JVM. The
> java label is "bin_t". And I checked using this:
> 
> sesearch -s bin_t -t user_home_t -c file -p read -Ad
> 
> And it doesn't seem to have a rule that allows bin_t to read a file
> with user_home_t label.
> 
> What's the right way to do this if any? Then, I also try to confine
> port accesses for Test.class, e.g. I only allow it to access ports
> 1234 and 2345. Same question, what's the right way to do this?

I think you are conflating file labels with process labels.  The
/usr/sbin/httpd file is labeled with the httpd_exec_t type; the running
httpd process runs in the httpd_t domain (to be precise, init_t
transitions to httpd_t upon executing httpd_exec_t).  bin_t is just a
generally executable file type that doesn't cause a domain transition
(as no domain transition is defined in policy on it), so a process that
execs a bin_t file will just stay in its domain.  You want to create a
new domain and run your program in that; if you are running it through
an interpreter, then you can force it into the target domain via
runcon.
