Subject: Re: How about future of MLS?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200309091050.57371.yanjunwu@sonata.iscas.ac.cn>
References: <200309080810.12991.yanjunwu@sonata.iscas.ac.cn>
	 <1063023949.8041.42.camel@moss-spartans.epoch.ncsc.mil>
	 <200309091050.57371.yanjunwu@sonata.iscas.ac.cn>
Content-Type: text/plain
Message-Id: <1063129289.8041.613.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Sep 2003 13:41:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-08 at 22:50, Wu Yanjun wrote:
> Though I subscribed SELinux maillist nearly one year, I am really a newbie on 
> security field. So correct me if I am wrong. 
> I just learned BLP model and read SELinux codes that implements MLS.  It seems 
> SELinux use the same MLS context for both subject and object. And the context 
> contains two levels, say high and low. I can understand why a subject binds 
> two levels, but I'm confused why objects also have high and low levels. Is 
> there any senerio we could make use of them two for an object? 

The MLS model was described in the Final Report and Formal Top-Level
Specification available from http://www.cs.utah.edu/flux/flask.  An
object may serve as a proxy for a subject, e.g. sockets and network
devices, or may represent the private state of a subject, e.g. memory,
or may act as a communication channel between multilevel subjects, so
that it may be useful to assign it two levels.

> Also I am interested in what aspects your excellent team plan to enhance the 
> MLS policy component. I hope I could do something for its improvement.

There is some debate about whether the decoupling of the MLS and TE
policies (described in the reports mentioned above) in Flask was a good
idea.  So one option would be to reintegrate them, with the ability to
specify separate TE access vectors for each MLS relation, in order to
better support least privilege for trusted subjects.

Regardless of whether this approach is taken, the MLS configuration
requires further work to correctly map each SELinux permission to the
corresponding set of MLS base permissions (information flows), and the
TE configuration requires further work to identify domains that need to
act as trusted subjects.  Polyinstantiated / multi-level directory
support will be needed to support userspace, and a program for selecting
the current level will be needed.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
