Subject: Re: pam_selinux and selinuxfs questions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1077135048.6667.29.camel@kusturica>
References: <1077135048.6667.29.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077136518.17849.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 15:35:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-18 at 15:10, Magosányi Árpád wrote:
> 1.
> Now I am here:
> secadm@szoketto-TCB:~$ getcon
> kernel_u:boot_r:tcb_ssh_d
> 
> I would like to put pam_selinux to /etc/pam.d/ssh, and get here:
> secadm@szoketto-TCB:~$ getcon
> secadm:tcb_user_r:tcb_user_d
> 
> The pam config part seems to be okay, I am struggling with the
> selinux config part. What kind of transitions, etc should I allow?

Look at the example ssh policy.  If you are using our constraints file,
then you'll need to assign privuser, privrole, and privowner attributes
to tcb_ssh_d so that it can transition to other user identities and
roles and can label the pty properly.  It needs to get security
decisions (can_getsecurity macro), set its exec context (can_setexec
macro), transition to the user domain (domain_trans macro), relabel the
pty, etc.  

> 2. What do each file does in /selinux? What is the security implication
> of read and write acces to them?
> access
> context
> create
> enforce
> load
> policyvers
> relabel
> user

Described in selinux-doc/README.  The example policy provides a
can_getsecurity() macro that allows access to the nodes that are simply
used to obtain security decisions, a can_setenforce() macro that allows
setting of the enforce flag, and a can_loadpol() macro that allows
reloading the policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
