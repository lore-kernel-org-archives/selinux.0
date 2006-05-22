Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4MG7NqK017193
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 12:07:23 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4MG7LdN012085
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 16:07:22 GMT
Received: by py-out-1112.google.com with SMTP id f25so1399914pyf
        for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 09:07:21 -0700 (PDT)
Message-ID: <4471E186.2060500@gmail.com>
Date: Tue, 23 May 2006 01:06:30 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: coderman <coderman@gmail.com>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: Which filesystem is the best for SELinux
References: <446E02CE.7050007@gmail.com>	 <200605212330.23218.russell@coker.com.au> <4ef5fec60605220503u6ffa3b91hecb4a58d1f465b00@mail.gmail.com>
In-Reply-To: <4ef5fec60605220503u6ffa3b91hecb4a58d1f465b00@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

coderman wrote:
> On 5/21/06, Russell Coker <russell@coker.com.au> wrote:
>> On Saturday 20 May 2006 03:39, Tetsuji Maverick Rai
>> <tetsuji.maverick.rai@gmail.com> wrote:
>> > ... I'm wondering
>> > which filesystem to use.  I want journaling filesystem, and stability
>> > comes first, then speed.
>> ...
>> If you don't like ext3 then it seems that XFS is your only option for
>> running
>> SE Linux.
> 
> i would also recommend XFS and have been using it for many years.  you
> may need to build a kernel with "XFS Security Label support" enabled
> if it is not present already.
> 
> the reasons i prefer XFS over ext3 are:
> - faster file system creation, especially for very large volumes
> (hundreds of GB+)
> - faster journal recovery upon failure
> - optional quota support
> 
> the reasons you might want to use ext3 instead of XFS:
> - many distributions do not support installing to or booting from XFS
> - ext3 can be mounted as an ext2 file system during recovery or for
> other reasons.
> 
hmm...

I have already installed SELinux on jfs. :)   According to SELinux
document, jfs is also supported (of course security label support is
enabled in the kernel config) and I compared the speeds on benchmark page.
http://linuxgazette.net/102/piszcz.html
but it's difficult to tell which is "best".

- -Tetsuji
- --
Tetsuji 'Maverick' Rai
Main http://maverick6664.bravehost.com/
Profile:
http://setiweb.ssl.berkeley.edu/beta/view_profile.php?userid=123
pubkey http://mav.atspace.com/tmr_at_gmail.txt
PGP Key ID: 82335CD9
Key fingerprint = 41CA 94B4 2A89 3FF1 5B11  BC37 D597 E667 8233 5CD9

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEceGF1ZfmZ4IzXNkRAoePAJ0Sko8ZkZvMwA26sDLjl1o7AeFObgCeImsI
ltWRM7LvFa1wYaRlqC2hV2k=
=s8xw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
