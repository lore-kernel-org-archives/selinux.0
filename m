Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BHHOh4018361
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 13:17:24 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7BHHNUI012762
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 17:17:23 GMT
Received: by rv-out-0708.google.com with SMTP id f25so2148793rvb.54
        for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 10:17:22 -0700 (PDT)
Message-ID: <dd18b0c30808111017m5f2530afjd32603970b00c11b@mail.gmail.com>
Date: Mon, 11 Aug 2008 10:17:22 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: Request for multiple mailing lists
Cc: "Vikram Ambrose" <Vikram.Ambrose@windriver.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <7e0fb38c0808110834h5aba3191p5baafa20e7037eda@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <489B25B6.4080309@windriver.com>
	 <7e0fb38c0808110834h5aba3191p5baafa20e7037eda@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 11, 2008 at 8:34 AM, Eric Paris <eparis@parisplace.org> wrote:
> On Thu, Aug 7, 2008 at 12:41 PM, Vikram Ambrose
> <Vikram.Ambrose@windriver.com> wrote:
>
>> The SELinux list is not a place for non-SELinux maintainers, like Tresys to
>> discuss their policies within themselves. Would it be alright for me and the
>> other developers in my company to use the SELinux list to discuss our
>> policies? Or the next company that decides to adopt SELinux? RedHat goes as
>> far as to using the SELinux list as a communication channel with Tresys.
>> Unless there has been some agreement made between the SELinux gatekeepers
>> (NSA?) , Tresys and Redhat, I find this a misuse of the mailing list.
>
> Some misunderstanding.  Tresys is the refpolicy maintainer.  The
> intention of refpolicy is to be a single upstream policy on which
> others can build, extend, and make their own changes.  Hopefully all
> generically useful changes that people make to policy get sent back to
> refpolicy.  We don't hear tresys discuss their custom policies, they
> only talk about the general refpolicy, of which one of their employees
> spends a great deal of maintaining for the benefit of us all.
>
>> As I see it, the current list should be split into 3.
>
> I'm willing to accept and think 2 lists is a good idea.  selinux-list
> and selinux-policy-list.  Where selinux-list deals with anything that
> comes along, be it userspace, kernel, my BLAH is broken, this tool
> sucks, etc etc.  selinux-policy-list is for policy PATCHES ONLY.
> There are some people who really follow both closely, but we do have
> enough specialists who care 99% about policy those of us who care only
> 1% about policy.  Sure I'll subscribe to both, but I'm going to ignore
> policy list.  I figure if any discussion comes up on policy-list that
> needs userspace changes someone will poke me or they will mention it
> on the general list.  I think moving policy patches and only patches
> that need review to go into refpolicy onto its own list can help a
> number of people better focus on things.  Chris can find those patches
> without wading through crap and accept/reject them.  I can ignore
> them.
>
> My suggestion would be
>
> selinux-list @ nsa - general selinux discussion including userspace
> and kernel patches
> selinux-policy-list @ whoever - PATCHES intended for refpolicy
>
> -Eric
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

Hey,
I like the idea, sign me up.
I'll just remember to keep the conversation SELinux
related, instead of some off topic question. i.g.
http://www.engardelinux.org/modules/index/list_archives.cgi?list=selinux&page=0335.html&month=2008-02
usb_hcd_poll_rh_status (rh_timer_func)
Don't ask me why I did that.....

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
