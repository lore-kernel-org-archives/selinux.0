Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9Q89EJ0005383
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2008 04:09:14 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9Q89DFO021654
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2008 08:09:14 GMT
From: Jim Meyering <jim@meyering.net>
To: russell@coker.com.au
Cc: Mike Edenfield <kutulu@kutulu.org>, 472590@bugs.debian.org,
        bug-coreutils@gnu.org, Vikram Noel Ambrose <noel.ambrose@gmail.com>,
        selinux@tycho.nsa.gov,
        =?utf-8?B?T25kxZllaiBWYcWhw61r?=
 <ovasik@redhat.com>
Subject: Re: RFC: changing the "+" in ls -l output to be "." or "+"
In-Reply-To: <200810261846.58879.russell@coker.com.au> (Russell Coker's
	message of "Sun, 26 Oct 2008 18:46:54 +1100")
References: <200803251523.34329.russell@coker.com.au>
	<87mygumq37.fsf@rho.meyering.net> <4901CB4B.3030306@kutulu.org>
	<200810261846.58879.russell@coker.com.au>
Date: Sun, 26 Oct 2008 09:09:10 +0100
Message-ID: <87y70bu6ah.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> wrote:

> On Saturday 25 October 2008 00:19, Mike Edenfield <kutulu@kutulu.org> wrote:
>> Jim Meyering wrote:
>> > A desire for compatibility makes "+" look good.
>> > "." is appealing for SELinux-only because it's inconspicuous.
>>
>> Speaking as a fairly new SELinux user/admin, having a "."
>> next to every file in my ls output is just as useful or
>> non-useful as having a "+" next to them, so does it really
>> buy anything?  I end up needing -Z either way.
>
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=472590
>
> The above URL has the history of this discussion.  I requested that there be
> no such notification.  I still believe that there should be nothing used in
> the case of SE Linux (although I could be convinced that the "." is OK if
> files with the context "system_u:object_r:file_t:s0" did not have it).
>
> But it seems that I have lost this debate.  Using "." is better than "+", and
> my request to have none of this in Lenny has been accepted so we have some
> time to work on this before Lenny+1.
>
>> Based on the kind of real-world problems I've had, the most
>> useful thing ls could tell me about a file on my SELinux
>> system would be that it *should* have a label and *doesn't*,
>> something like:
>>
>> if ( selinux_enabled )
>>    if ( label == NULL || label == fs.defaultlabel )
>>      use "!"
>>    else
>>      use " "
>> else if ( anything else )
>>    use "+"
>
> That sounds quite reasonable.

Actually, I'm leaning your way, now, and agree.

If you, Russell, write the patch (w/NEWS and docs would be really nice)
I'll make the switch upstream pretty soon.  It'd be nice to give the
austin group a heads up, too, since this behavior would be contrary to
POSIX.  I don't think it's worth it to make this depend on the setting
of the POSIXLY_CORRECT envvar.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
