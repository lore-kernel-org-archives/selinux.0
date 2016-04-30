Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3UB4OLw024185
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 07:04:24 -0400
To: =?UTF-8?Q?Beno=c3=aet_Knecht?= <benoit.knecht@fsfe.org>,
 John Pham <jhnphm@gmail.com>
References: <20110405004514.4762.50855.reportbug@atlas.lan>
 <20110405004514.4762.50855.reportbug@atlas.lan>
Subject: Re: policycoreutils: fixfiles does not relabel contents of btrfs
 subvolumes
Cc: 620907@bugs.debian.org, selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <f6f31dad-1059-1206-2346-7490c04c9f59@debian.org>
Date: Sat, 30 Apr 2016 13:04:04 +0200
MIME-Version: 1.0
In-Reply-To: <20110405004514.4762.50855.reportbug@atlas.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

tag 620907 + moreinfo
forwarded 620907 selinux@tycho.nsa.gov
thanks

On Mon, 04 Apr 2011 20:45:14 -0400 John Pham <jhnphm@gmail.com> wrote:

Hi,

 >
 > The fixfiles script seems unable to relabel anything in btrfs 
subvolumes. This appears to be due to the contents of subvolumes not 
counting as being on a filesystem of type 'btrfs', according to find 
which is called by this script.

I know this is an old bug, but are you still able to reproduce it?

I see that there are some changes related to this to fixfiles script, 
but I cannot verify as I'm not using btrfs myself.

Cheers,

Laurent Bigonville

FTR, the debian bug is located at: 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=620907
