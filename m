Subject: Re: [PATCH] file context sort in libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Ashworth <cashworth@tresys.com>
Cc: SELinux-dev@tresys.com, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1144959475.10749.12.camel@popeye>
References: <1144685935.32555.32.camel@popeye.columbia.tresys.com>
	 <1144765688.20422.9.camel@moss-spartans.epoch.ncsc.mil>
	 <1144866072.27883.53.camel@popeye.columbia.tresys.com>
	 <1144959475.10749.12.camel@popeye>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 09:46:14 -0400
Message-Id: <1145022374.17185.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-04-13 at 16:17 -0400, Christopher Ashworth wrote:
> On Wed, 2006-04-12 at 14:21 -0400, Christopher Ashworth wrote:
> > There was an error in my patch that handled the escape character '\'
> > incorrectly.  The attached patch, modified to fix this bug, replaces the
> > previous patch.
> 
> And, I managed to leave one last bug in there, for good measure.  Sigh.
> 
> Re-fixed version attached.

Thanks, merged as libsemanage 1.6.6.

Dan - this means that libsemanage will be sorting the generated file
contexts, so any changes in heuristics that you want would now go into
the libsemanage sorting logic.  This should address the modular strict
policy file contexts problem, but we still have the optionals-in-base
issue to sort out there before modular strict policy can work correctly,
IIUC.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
