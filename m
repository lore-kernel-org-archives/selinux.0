Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8BKb1xX013751
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 16:37:03 -0400
Received: by qcpx40 with SMTP id x40so625599qcp.12
        for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 13:37:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com>
References: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com>
	<CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com>
Date: Tue, 11 Sep 2012 13:37:01 -0700
Message-ID: <CAFftDdqD-VRvrFjbvg=jxsFyo8Ucp50bOwS1Cs+0GLAe9vNMFg@mail.gmail.com>
Subject: Re: Problem with SEManager app on Seandroid 4.0.4
From: William Roberts <bill.c.roberts@gmail.com>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My guess is you need to change the permissions of /selinux/*
(/selinux/booleans for the booleans) to system system.

the init.rc needs to have chown system system for all of the booleans,
setenforce etc

    chown system system /selinux/enforce
    chown -R system system /selinux/booleans
    chown system system /selinux/commit_pending_bools

You'll need to patch in the recursive support or enumerate all the
bools. The patch for recursive support can be found:
https://android-review.googlesource.com/#/c/32220/

Hope this helps.


On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino
<cesar.maiorino@gmail.com> wrote:
> I finally got a version of seandroid (4.0.4) running on my Qualcomm MSM8960
> Mobile Development Platform. This required some manual intervention as the
> patch files did not all apply cleanly, so it's possible that I've messed
> something up in the process.
>
> That being said, the SEManager app does not let me change any settings aside
> from toggling "MAC Mode" on and off. So I can't change '"SELinux Mode"
> (stuck in permissive), and I can't change any of the Booleans.
>
> AVC and MAC logging seem to be working.
>
> Any ideas?
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
