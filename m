Message-ID: <51C840AB.2030606@tycho.nsa.gov>
Date: Mon, 24 Jun 2013 08:50:51 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: pcre 8.33 changes restorecon behavior
References: <20130622161711.GA2010@siphos.be>
In-Reply-To: <20130622161711.GA2010@siphos.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/22/2013 12:17 PM, Sven Vermeulen wrote:
> Hi guys
>
> Since libpcre 8.33, the behavior of restorecon is different. Take the
> context for /sbin for instance:
>
> Before libpcre 8.33:
>    # matchpathcon /sbin
>    /sbin	system_u:object_r:bin_t:s0
>
> With and after libpcre 8.33:
>    # matchpathcon /sbin
>    /sbin	<<none>>
>
> As a result, trying to reset the label fails:
>
> # restorecon -Fv /sbin
> restorecon:  Warning no default label for /sbin
>
> Is this a bug in libpcre or are we using it differently? According to
> Alphat-PC, it is due to rev 1313 of libpcre:
> http://vcs.pcre.org/viewvc?view=revision&revision=1313
>
> Thanks to Alphat-PC for reporting and debugging it at
> https://bugs.gentoo.org/show_bug.cgi?id=471718

Looks to me as if the compiled regex format changed.  So that would be a 
problem for previously compiled regexes cached in the .bin files under 
/etc/selinux/$SELINUXTYPE/contexts/files.  You would need to re-run 
sefcontext_compile to regenerate them or delete them and fall back to 
loading from the source configurations.

Not sure if there is a way to automatically detect the change in format 
and handle the conversion on the libselinux side.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
