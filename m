Subject: Re: Relabeling Network Objects ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rodrigo Vivi <vivijim@br.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200606091812.09677.vivijim@br.ibm.com>
References: <200606091812.09677.vivijim@br.ibm.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:32:17 -0400
Message-Id: <1150122737.8086.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-09 at 18:12 -0300, Rodrigo Vivi wrote:
> Hi folks,
> 
> Is it possible to relabel a network object {netif, node} ? 
> if yes, how can I do it ?
> 
> Or can I easily change the context assigned on creation of an specific {netif, 
> node} like a tun interface with a specific address ??

You can assign a security context to a specific netif or node via
semanage.  This will then rebuild the policy with that definition and
load it into the kernel.  Subsequent network permission checks should
then use the assigned security context.

Note however that the new SECMARK mechanism largely obsoletes the use of
netif and node contexts going forward.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
