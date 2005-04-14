Subject: Re: Provide finer-grained booleans for execmem/execmod, please
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   selinux@tycho.nsa.gov
In-Reply-To: <425E7552.3030002@redhat.com>
References: <1113485318.373.39.camel@moss-spartans.epoch.ncsc.mil>
	 <425E7552.3030002@redhat.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 10:06:15 -0400
Message-Id: <1113487575.373.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-14 at 09:51 -0400, Daniel J Walsh wrote:
> We can do that, the problem is we are having an explosion of booleans.  
> I just don't want to
> get to the point where every app that needs execmem has a boolean.  
> Maybe we need two booleans
> allow_trusted_execmem, allow_untrusted_execmem.  So ones that are 
> explainable like Java and X
> would be trusted and other random ones that we can not necessarily 
> explain would be untrusted.

I wouldn't classify java as "trusted", but I understand your meaning.
Likely want a separation for execmem between system programs like X,
udev and kudzu and user programs like java.  Possibly one per user
domain, so you can allow it to user_t but deny it for sysadm_t (or at
least separate booleans for unprivileged user domains vs. admin
domains).

execmod possibly doesn't require further booleans since it is already
tied to a particular shared library type (texrel_shlib_t), although if
you allow execmod to other types (e.g. shlib_t), that should likely be
covered by a boolean or limited to very specific domains.  

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
