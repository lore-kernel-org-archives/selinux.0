Subject: Re: swig wrapper bug: setexeccon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1146836041.11149.2.camel@sgc.columbia.tresys.com>
References: <1146836041.11149.2.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 05 May 2006 09:49:53 -0400
Message-Id: <1146836993.23863.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-05 at 09:34 -0400, Christopher J. PeBenito wrote:
> Having a problem with the swig wrapper:
> 
> >>> import selinux
> >>> selinux.setexeccon('user_u:system_r:java_t')
> Traceback (most recent call last):
>   File "<stdin>", line 1, in ?
> TypeError: argument number 1: a 'security_context_t *' is expected, 'str(user_u:system_r:java_t)' is received

Glauber posted some patches for the libselinux swig wrappers that
haven't been merged upstream yet, but are in rawhide IIUC.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
