Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BFnC1D031272
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 11:49:12 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7BFnBPn014815
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 15:49:12 GMT
Received: by wf-out-1314.google.com with SMTP id 23so2091100wfg.30
        for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 08:49:11 -0700 (PDT)
Message-ID: <7e0fb38c0808110849p68fa19c8q2fdb6dfab8db8b97@mail.gmail.com>
Date: Mon, 11 Aug 2008 11:49:10 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: russell@coker.com.au
Subject: Re: long contexts
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200808112100.25447.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808112100.25447.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 11, 2008 at 7:00 AM, Russell Coker <russell@coker.com.au> wrote:
> runcon -l s0:`/tmp/test.pl 630`-s0:`/tmp/test.pl 1023` id
>
> The above command fails with error "File too large".  It seems that for full
> support of ranges with the pessimal combination of categories we could have
> no more than about 700 categories.
>
> open("/selinux/context", O_RDWR)        = 3
> write(3, "unconfined_u:unconfined_r:unconfi"..., 4088) = -1 EFBIG (File too
> large)
>
> Above are the relevant lines from strace output.  I'm running Debian kernel
> 2.6.18.  I expect that a single page is used by the kernel to store the data
> written to /selinux/context.

It looks be be slightly smaller than 1 page::

fs/libfs.c::simple_transaction_get()

does:
        ar = (struct simple_transaction_argresp *)get_zeroed_page(GFP_KERNEL);

where the simple_transaction_argresp is:
struct simple_transaction_argresp {
        ssize_t size;
        char data[0];
};

So its really one page - sizeof(ssize_t) nothing to break here   :)

If anyone comes up with a need for this in reality would could
probably make it bigger, but for now, I think this code is good....

-Eric




>
> Below is the contents of /tmp/test.pl.
>
> #!/usr/bin/perl
>
> for($i=1; $i < $ARGV[0]; $i +=2)
> {
>  print "c$i,";
> }
> print "c1023\n";
>
>
> NB  I don't have any good reason for wanting to do this.  I just wondered if I
> could break anything.
>
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
>
> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
