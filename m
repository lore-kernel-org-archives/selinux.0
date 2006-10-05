Subject: xinetd SELinux support (Was: Re: [PATCH v4 1/2] NetLabel: secid
	reconciliation support)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        SE Linux <selinux@tycho.nsa.gov>, eparis@redhat.com,
        James Morris <jmorris@namei.org>, Steve Grubb <sgrubb@redhat.com>
In-Reply-To: <C89A4409-F96D-430D-8DF5-7BEF0F972A4F@nall.com>
References: <36282A1733C57546BE392885C0618592015CF96F@chaos.tcs.tcs-sec.com>
	 <1159993643.19176.256.camel@moss-spartans.epoch.ncsc.mil>
	 <45241EFF.2000108@hp.com> <200610041712.00629.sgrubb@redhat.com>
	 <C89A4409-F96D-430D-8DF5-7BEF0F972A4F@nall.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 08:15:42 -0400
Message-Id: <1160050542.2132.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 17:03 -0500, Joe Nall wrote:
> On Oct 4, 2006, at 4:12 PM, Steve Grubb wrote:
> 
> > On Wednesday 04 October 2006 16:52, Paul Moore wrote:
> >> I think we are all in agreement that the current xinetd patch is  
> >> broken.
> >>  Hopefully Steve Grubb will have fix it soon (I just added him as  
> >> a CC).
> >
> > In my opinion, this should be in bugzilla. This is the first I  
> > heard of xinetd
> > being broken. LSPP issues that need quick solutions like this can  
> > get lost in
> > mail.
> 
> Using Eric's kernel and rawhide xinetd, I get what I expect from this  
> simple test -
> 
> [joe@mls user_u:user_r:user_t:SystemLow ~]$ telnet localhost test
> Trying 127.0.0.1...
> Connected to localhost.localdomain (127.0.0.1).
> Escape character is '^]'.
> uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm), 
> 6(disk),10(wheel) context=user_u:user_r:user_t:SystemLow
> Connection closed by foreign host.
> 
> [joe@mls user_u:user_r:user_t:SystemLow ~]$ newrole -l S-S
> ...
> [joe@mls user_u:user_r:user_t:SECRET ~]$ telnet localhost test
> Trying 127.0.0.1...
> Connected to localhost.localdomain (127.0.0.1).
> Escape character is '^]'.
> uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm), 
> 6(disk),10(wheel) context=user_u:user_r:user_t:SECRET
> 
> Where /etc/xinetd.d/test is
> service test
> {
>          flags           = LABELED
>          socket_type     = stream
>          wait            = no
>          user            = root
>          group           = root
>          server          = /usr/bin/id
>          log_on_failure  += USERID
>          disable         = no
> }
> 
> Can anyone provide a simple test that demonstrates how xinetd is broken?

It isn't broken from a MLS perspective, but it yields unexpected
behavior for TE.  References:
http://www.redhat.com/archives/redhat-lspp/2005-September/msg00125.html
http://marc.theaimsgroup.com/?l=selinux&m=115988978821514&w=2

We would expect your "server" to run in a domain based on the service
(e.g. the id_t domain if such a thing existed) with permissions limited
to least privilege for its purpose, or alternatively, to run in a
derived domain based on both the peer and the service (e.g. the
user_id_t domain for the id service launched from a user_t client).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
