Subject: Re: SECMARK
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shahbaz khan <shazalive@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7b740b700709011502u602993bfjf74cbbbfd3f0f97a@mail.gmail.com>
References: <7b740b700709011502u602993bfjf74cbbbfd3f0f97a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 08:11:48 -0400
Message-Id: <1188907908.5227.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-09-02 at 03:02 +0500, shahbaz khan wrote:
> Hi,
>  
> Just wanted to know how secmark adds labeling information to packets.
> Does it strip off to packet to do so or what? Could'nt find any
> relevant reading stuff on it either.

There is a secmark field in the sk_buff structure.  See:
http://james-morris.livejournal.com/11010.html
for a description of secmark by its creator, James Morris.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
