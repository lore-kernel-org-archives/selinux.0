Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u52LpwNU011523
 for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2016 17:51:58 -0400
Received: by mail-qg0-f52.google.com with SMTP id 52so3342772qgy.0
 for <selinux@tycho.nsa.gov>; Thu, 02 Jun 2016 14:51:39 -0700 (PDT)
Message-ID: <5750AA67.9030806@quarksecurity.com>
Date: Thu, 02 Jun 2016 17:51:35 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: John Chludzinski <john.chludzinski@vivaldi.net>
CC: Selinux <selinux@tycho.nsa.gov>
Subject: Re: XWindows and CLIP?
References: <1223101c554790d34307b1736bbca1fa@mail.vivaldi.net>
In-Reply-To: <1223101c554790d34307b1736bbca1fa@mail.vivaldi.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

John Chludzinski wrote:
> What are the issues with XWindows and CLIP? Why is CLIP XWindow-less?

CLIP strives to be a minimal system suited to secure solutions and does 
not come with software not necessary for such systems (e.g., cross 
domain solutions).

> Is there something inherently unsecure with the XWindow client/server
> model?

Xorg manages interactions between programs running under X itself and is 
therefore an object manager (similar to how an RDBMS is an object 
manager that manages rows and tables).

There is work to extend SELinux controls to Xorg (XACE) but without 
using XACE and X SELinux policy you cannot meaningfully manage 
information flow between X applications uses SELinux.
