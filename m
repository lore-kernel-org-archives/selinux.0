From: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: How about future of MLS?
Date: Tue, 9 Sep 2003 10:50:57 +0800
Cc: SELinux@tycho.nsa.gov
References: <200309080810.12991.yanjunwu@sonata.iscas.ac.cn> <1063023949.8041.42.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1063023949.8041.42.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200309091050.57371.yanjunwu@sonata.iscas.ac.cn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Though I subscribed SELinux maillist nearly one year, I am really a newbie on 
security field. So correct me if I am wrong. 
I just learned BLP model and read SELinux codes that implements MLS.  It seems 
SELinux use the same MLS context for both subject and object. And the context 
contains two levels, say high and low. I can understand why a subject binds 
two levels, but I'm confused why objects also have high and low levels. Is 
there any senerio we could make use of them two for an object? 
Also I am interested in what aspects your excellent team plan to enhance the 
MLS policy component. I hope I could do something for its improvement.

> I would expect the MLS policy component to eventually be enhanced; the
> fact that it hasn't been done yet is just a reflection of a lack of
> anyone driving requirements for it, as most people seem satisfied with
> the RBAC/TE model.  Do you have a particular need for MLS support?  Note
> that TE can express MLS, so that is an alternative approach.

-- 
Best regards,
Wu Yanjun

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
