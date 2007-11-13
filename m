Subject: Re: is the string "<<none>>" in a header anywhere?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <87y7d3yb80.fsf@rho.meyering.net>
References: <87y7d3yb80.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 09:58:26 -0500
Message-Id: <1194965906.22155.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-11-12 at 12:06 +0100, Jim Meyering wrote:
> Coreutils' install.c currently compares a context against the
> magic string, "<<none>>":
> 
>   /* If there's an error determining the context, or it has none,
>      return to allow default context */
>   if ((matchpathcon (file, st.st_mode, &scontext) != 0) ||
>       STREQ (scontext, "<<none>>"))
>     {
>       if (scontext != NULL)
>         freecon (scontext);
>       return;
>     }
> 
> BTW, matchpathcon(8) does, too.
> Is there a better way to test for that condition?
> It'd be nice if that string were available via a libselinux header,
> but I don't see it on rawhide:
> 
>     $ grep none $(rpm -ql libselinux-devel|grep -F .h)
>     [Exit 1]
> 

matchpathcon(3) should never return "<<none>>" at all to the caller.
If it hits a <<none>> in the spec, it returns -1 with errno ENOENT.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
