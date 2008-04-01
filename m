Subject: Re: SSH + file_contexts + kerberos
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Karrels, Jeffrey J (US SSA)" <jeffrey.karrels@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4AE25A7D8CBE4E4DA8E87173237DE27E8B91@blums0042.bluelnk.net>
References: <4AE25A7D8CBE4E4DA8E87173237DE27E8B91@blums0042.bluelnk.net>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 08:16:26 -0400
Message-Id: <1207052186.5610.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-31 at 15:59 -0700, Karrels, Jeffrey J (US SSA) wrote:
> Hello everyone.
> 
> I have two questions:
> 
> 1) Is there a preferred way to search this lists archives?

http://marc.info/?l=selinux is an unofficial archive that is easily
searchable.  And there is always google.

> 2) I have a problem I could use a pointer on. I am using the 1217
> reference policy on Machine A. I have a script on Machine A that
> attempts to SSH into another Machine B with an older policy on it (set
> in permissive mode). When I set Machine A to enforcing and call the
> script, when the SSH gets called I get:
> file_contexts: invalid context system_u:object_r:krb5_conf_t:s0.
> 
> I am assuming that this is because Machine B does not know of type
> krb5_conf_t. Is there a way to still SSH from Machine A to Machine B
> without updating Machine B's policy? 

ssh'ing does not update the machine's policy.  What is presumably
happening here is that ssh or sshd internally calls matchpathcon() to
decide how to label some file it is creating, and there is an error in
your file_contexts configuration file on the client or server.  Run the
following command on machine A and on machine B:

setfiles -c /etc/selinux/$SELINUXTYPE/policy/policy.N /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts

where $SELINUXTYPE is the value from your /etc/selinux/config file and N
is the policy version that you have.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
