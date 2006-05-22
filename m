Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4MG16Do016763
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 12:01:06 -0400
Received: from wx-out-0102.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4MG15dN010891
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 16:01:05 GMT
Received: by wx-out-0102.google.com with SMTP id i29so772192wxd
        for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 09:01:05 -0700 (PDT)
Message-ID: <4ef5fec60605220503u6ffa3b91hecb4a58d1f465b00@mail.gmail.com>
Date: Mon, 22 May 2006 05:03:00 -0700
From: coderman <coderman@gmail.com>
To: russell@coker.com.au
Subject: Re: Which filesystem is the best for SELinux
Cc: "Tetsuji Maverick Rai" <tetsuji.maverick.rai@gmail.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <200605212330.23218.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <446E02CE.7050007@gmail.com>
	 <200605212330.23218.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/21/06, Russell Coker <russell@coker.com.au> wrote:
> On Saturday 20 May 2006 03:39, Tetsuji Maverick Rai
> <tetsuji.maverick.rai@gmail.com> wrote:
> > ... I'm wondering
> > which filesystem to use.  I want journaling filesystem, and stability
> > comes first, then speed.
> ...
> If you don't like ext3 then it seems that XFS is your only option for running
> SE Linux.

i would also recommend XFS and have been using it for many years.  you
may need to build a kernel with "XFS Security Label support" enabled
if it is not present already.

the reasons i prefer XFS over ext3 are:
- faster file system creation, especially for very large volumes
(hundreds of GB+)
- faster journal recovery upon failure
- optional quota support

the reasons you might want to use ext3 instead of XFS:
- many distributions do not support installing to or booting from XFS
- ext3 can be mounted as an ext2 file system during recovery or for
other reasons.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
