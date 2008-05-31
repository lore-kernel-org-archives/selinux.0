Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4V0YROn022382
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 20:34:27 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4V0YQQF023120
	for <selinux@tycho.nsa.gov>; Sat, 31 May 2008 00:34:26 GMT
Received: by an-out-0708.google.com with SMTP id d30so107436and.75
        for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 17:34:26 -0700 (PDT)
Message-ID: <dd18b0c30805301734q43f4509cle3e89be4451f53f@mail.gmail.com>
Date: Sat, 31 May 2008 00:34:26 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Charles, Theodore" <txc5810@lausd.net>
Subject: Re: question about security
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Matthew Hammer" <matthewhammer89@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <367BE2FA995D5747B2E75B330734CA616BD237@MAILBE-LA17.lausd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30805301004h5c9bbf7fmb4bfced81264b8c2@mail.gmail.com>
	 <20080530135146.11fa7b83@matthew-laptop>
	 <dd18b0c30805301157x661896c4j65655167ba22df07@mail.gmail.com>
	 <48405512.2040503@redhat.com>
	 <dd18b0c30805301329m3a07d004nd86a91c785596912@mail.gmail.com>
	 <367BE2FA995D5747B2E75B330734CA616BD237@MAILBE-LA17.lausd.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 30, 2008 at 10:10 PM, Charles, Theodore <txc5810@lausd.net> wrote:
> From what I've read, there was an exploit in the way Comcast registers and updates its DNS records with the domain registar (I've already forgotten the name). And, it was this exploit that the "hackers" reported to Comcast, but Comcast ignored. Regardless, this is not a question of whether or not Comcast should be using SELinux or UNIX or Windows Server 2008 or <insert OS here>. This is a question of properly secured methods of communication between two computers on the Internet. I don't think that's applicable to SELinux in the general sense, because most policies deal with objects interacting with the local machine. I would suspect this is more applicable to something like ipfw / iptables / netfilter and possibly their interaction with the SELinux policies. If you really wanted to prevent anyone from connecting to your computer (and making it practically unusable), you could try something like this:
>
> iptables -t nat -A PREROUTING -i eth0 -J DROP (not tested)
>
> But then you'd pretty much have an unusable internet connected machine (well, technically, you'd still be able to connect out, but diagnosing network problems might be a pain). If I am wrong, please bring it to my attention. :)
>
> Last I noticed, Comcast is in fact back up, but I'm sure they're holding their tale between their legs, and let's hope this does not happen again.
>
>
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov on behalf of Justin Mattock
> Sent: Fri 5/30/2008 1:29 PM
> To: Daniel J Walsh
> Cc: Matthew Hammer; selinux@tycho.nsa.gov
> Subject: Re: question about security
>
> On Fri, May 30, 2008 at 7:27 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Justin Mattock wrote:
>> | On Fri, May 30, 2008 at 5:51 PM, Matthew Hammer
>> | <matthewhammer89@gmail.com> wrote:
>> |> On Fri, 30 May 2008 17:04:41 +0000
>> |> "Justin Mattock" <justinmattock@gmail.com> wrote:
>> |>
>> |>> Hello; First I need to start with a status: SELinux seems to be
>> |>> handling nicely with the latest git, and refpolicy. You guys really do
>> |>> a good job.
>> |>> Now for the question: I noticed reading the New York Times that
>> |>> Comcast was hacked into, after reading the article I couldn't help but
>> |>> ask the question
>> |>> of "If comcast was using Linux with SELinux would this have happened".
>> |>> So the question to SELinux is: If Comcast was using Linux, with
>> |>> SELinux on there servers
>> |>> would this attack have been prevented? What should Comcast have had
>> |>> with there set up to better protect them from this type of
>> |>> attack?(even though they probably use windows)
>> |>> How would regular users and small businesses protect themselves from
>> |>> this type of terrorism?
>> |>> regards;
>> |> My understanding of the comcast hack was that the hackers altered
>> |> Comcast's registration information with the vendor that registers their
>> |> domain. So no, the problem wasn't anything internal with comcast's own
>> |> system.
>> |>
>> |> --
>> |> Matthew Hammer
>> |>
>> |
>> | AAhh I see, the vendor that registers their domain.
>> |
>> Of course the next question is whether the vendor who registers their
>> doimains had been running SELinux, could it be stopped, and there is a
>> good possibility.
>>
>> Depending on the Version, SELinux prevents most buffer overflow attacks
>> on confined domains.
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.9 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>>
>> iEYEARECAAYFAkhAVPQACgkQrlYvE4MpobPWSwCfQnk59XT5A7vZ/hL8JtHJGBj5
>> 9fkAoJ+RKyeW/Vcd86U7syYUK9T17zwR
>> =tzTL
>> -----END PGP SIGNATURE-----
>>
>
> So if the vendor was protected with SELinux, the hacker would have had
> to really work hard at trying to tweak the numbers
> inside the vendors computer to cause this(edit a file), or is it  a
> wire tap scenario i.g. similar to arp spoofing.
>
> --
> Justin P. Mattock
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>

It sounds like a nice idea, but if there will be problems connecting,
and so forth then I'll pass, I was just wondering if they were using
SELinux
would this have been a better outcome.  As for what happened at
comcast, I really don't know, I just don't like hearing story's like
that, The positive side is the hackers exposed holes which can then be
fixed, but in this case the hackers exposed the holes, they just chose
to ignore them,(if this is the case) causing a more of a wakeup call
later in time.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
