From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: is the string "<<none>>" in a header anywhere?
In-Reply-To: <1194965906.22155.7.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Tue, 13 Nov 2007 09:58:26 -0500")
References: <87y7d3yb80.fsf@rho.meyering.net>
	<1194965906.22155.7.camel@moss-spartans.epoch.ncsc.mil>
Date: Tue, 13 Nov 2007 16:23:18 +0100
Message-ID: <87oddyp3tl.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2007-11-12 at 12:06 +0100, Jim Meyering wrote:
>> Coreutils' install.c currently compares a context against the
>> magic string, "<<none>>":
>>
>>   /* If there's an error determining the context, or it has none,
>>      return to allow default context */
>>   if ((matchpathcon (file, st.st_mode, &scontext) != 0) ||
>>       STREQ (scontext, "<<none>>"))
>>     {
>>       if (scontext != NULL)
>>         freecon (scontext);
>>       return;
>>     }
>>
>> BTW, matchpathcon(8) does, too.
>> Is there a better way to test for that condition?
>> It'd be nice if that string were available via a libselinux header,
>> but I don't see it on rawhide:
>>
>>     $ grep none $(rpm -ql libselinux-devel|grep -F .h)
>>     [Exit 1]
>>
>
> matchpathcon(3) should never return "<<none>>" at all to the caller.
> If it hits a <<none>> in the spec, it returns -1 with errno ENOENT.

I'm sure that's the way it's supposed to work (now),
but I debugged a failure (over a year ago) in which matchpathcon
returned 0 with scontext equal to that string.
libselinux logs suggest that this was fixed in early 2005:

  1.20 2005-01-04
          * Changed matchpathcon to return -1 with errno ENOENT for
            <<none>> entries, and also for an empty file_contexts configuration.

so maybe we'll have to wait a while longer for all legacy implementations
to disappear.

Since this is solely to work around old, buggy behavior,
there's no reason to provide anything more aesthetic.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
