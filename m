Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p821q4GE007407
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 21:52:05 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p821q3WR023732
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2011 01:52:03 GMT
Received: by iabz21 with SMTP id z21so3284340iab.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Sep 2011 18:52:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1314912106.2334.2.camel@vortex>
References: <201109011509.05872.russell@coker.com.au>
	<4E5F8BAA.6060208@redhat.com>
	<1314912106.2334.2.camel@vortex>
Date: Thu, 1 Sep 2011 21:52:02 -0400
Message-ID: <CACLa4ptfSU3obZ8OyMVFfKDsqwLQn58-O9YRUbCyU8=mLzn=tA@mail.gmail.com>
Subject: Re: policycoreutils manpages needed
From: Eric Paris <eparis@parisplace.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 1, 2011 at 5:21 PM, Guido Trentalancia
<guido@trentalancia.com> wrote:
> On Thu, 2011-09-01 at 09:42 -0400, Daniel J Walsh wrote:
>> On 09/01/2011 01:09 AM, Russell Coker wrote:
>> > Has anyone written manpages for genhomedircon, sepolgen-ifgen, and
>> > seunshare? If not is there someone with some spare time and man
>> > page writing skill?
>> >
>> We have man pages for genhomedircon and seunshare.  Although the
>> genhomedircon man page is rather sparse.
>
> If help is needed for manual pages, I can have a look and spare some
> time. I can start with genhomedircon as suggested by Dan unless other
> ideas are brought forward...

Just make sure you look at the 'queue' branch of the upstream repo
rather than the 'master' branch.  I'm pretty sure some of the man
pages Dan mentioned only exist in the queue branch.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
