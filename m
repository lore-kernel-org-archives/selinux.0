Subject: Re: Writing SELinux Policy...(Allow ALL, Deny Few)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D049EC66B@de01exm68.ds.mot.com>
References: <1210336991.6434.200.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805121034110.22560@us.intercode.com.au>
	 <1210595177.6206.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1211200563.7486.40.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D049EC66B@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Fri, 30 May 2008 10:18:26 -0400
Message-Id: <1212157106.12889.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-28 at 13:29 -0400, Hasan Rezaul-CHR010 wrote:
> Hi,
> 
> >From what I understand, given the SELinux framework...
> 
> EVERY THING by default is Denied, *except* what the policy explicitly
> allows...
> 
> How can I configure things (if at all possible), such that  
> EVERY THING by default is Allowed, *except* the specific things Denied
> in the policy !!
> 
> Is this doable ?

There is no deny statement in the current policy language.
As far as the mechanism is concerned, anything not allowed is denied.

unconfined_t is an example of domain that is allowed (just about)
everything.  You can use the same macros/interfaces it uses to construct
other similarly unconfined domains and then selectively remove rules if
you want to deny certain actions, but whether or not that will yield a
meaningful policy is another matter (e.g. denying direct write access to
a given file might be easily circumvented by controlling another domain
that has such write access or via more indirect information flows).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
