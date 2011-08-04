Subject: Re: [PATCH 006/155] libselinux: do not check fcontext duplicates
 on use
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <4E3AB236.4000404@redhat.com>
References: <4E39B41E.8060801@redhat.com>
	 <1312469298.20973.51.camel@moss-pluto>  <4E3AB236.4000404@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Aug 2011 11:14:58 -0400
Message-ID: <1312470898.20973.59.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-04 at 10:52 -0400, Eric Paris wrote:
> I don't understand.  Before this patch rec->validating wasn't being used
> at all and we always checked for dups.  With this patch we actually pay
> attention to what the application set.  As it turns out
> restorecon/fixfiles don't set the flag, but semanage fcontext does, so
> this is actually a case where the programs were right but the underlying
> library was wrong.  I'm fixing the library to pay attention to the flag.
>  What am I missing?

Oops, I read the patch backwards.  Never mind.
Technically the library was correct in that the original meaning of
validate was to validate the contexts, but I suppose this fits with the
sense of it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
