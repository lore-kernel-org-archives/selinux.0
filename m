Subject: Re: Context transition error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vince Le Port <vince.rafale@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <492709F5.2090801@gmail.com>
References: <492709F5.2090801@gmail.com>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 14:59:41 -0500
Message-Id: <1227297581.7319.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-11-21 at 20:20 +0100, Vince Le Port wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dear all,
> 
> I am working on a mean to change the nfs server context depending on the
> user who wants to access his files. I have planned to use MCS to do that.
> 
> Here is the approach for NFS:
> 
> Let us say, we have two users : client1 in s0:c1 and client2 in s0:c2
> If client1 wants to access his home directory mounted with NFS, then the
> NFS daemon will change his MCS category corresponding to the client MCS
> category
> That will limit the risk that client2 could access client1's files
> 
> Thus, for example my test program is launched in that context :
> sysadm_u:sysadm_r:sysadm_t:s0:c1.c2
> 
> Then that program makes a setcon in order to move into
> sysadm_u:sysadm_r:sysadm_t:s0:c1 and the following step is to move the
> program in that context sysadm_u:sysadm_r:sysadm_t:s0:c2
> 
> I have written the following semodule :
> 
> module localadmin 1.0;
> 
> require {
>         type sysadm_t;
>         class process setcurrent;
>         class process dyntransition;
> }
> 
> allow sysadm_t self:process { setcurrent dyntransition };
> 
> The problem is that this setcon does not work. Audit launches a
> dyntransition permission denied :
> 
> type=AVC msg=audit(1224660818.891:422): avc: denied { dyntransition }
> for pid=18334 comm="prog" scontext=sysadm_u:sysadm_r:sysadm_t:s0:c2
> tcontext=sysadm_u:sysadm_r:sysadm_t:s0:c1 tclass=process
> 
> It also seems impossible to return back to the original context s0:c1.c2
> , once s0:c1 is reached
> 
> Is it possible to allow this transition?
> 
> Thanks you for helping a SElinux newbie

The domain needs the mcssetcats attribute in order to pass the MCS
policy constraints.

You can use the mcs_process_set_categories() refpolicy interface if
building using the refpolicy infrastructure (i.e. yum install
selinux-policy-devel, make -f /usr/share/selinux/devel/Makefile
localadmin.pp).

I'm not sure what you are really planning to do though, as:
- obviously your program should not run in sysadm_t,
- The real processing for nfsd is handled by kernel threads, not a
userland process, and thus can change its credentials without going
through permission checks,
- you still need a mechanism of binding the client process security
context to the NFS request and conveying that to the server.

You may wish to have a look at the ongoing labeled NFS work:
http://selinuxproject.org/page/Labeled_NFS

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
