Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7JFZZE5031451
 for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2016 11:35:35 -0400
Received: by mail-pa0-f44.google.com with SMTP id ti13so17244910pac.0
 for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2016 08:35:32 -0700 (PDT)
Received: from localhost ([2404:e800:e600:57b:f993:56d7:a1e9:4e20])
 by smtp.gmail.com with ESMTPSA id 81sm7457890pfm.90.2016.08.19.08.35.29
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Aug 2016 08:35:30 -0700 (PDT)
Date: Fri, 19 Aug 2016 23:35:28 +0800
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: sepolicy and setools4
Message-ID: <20160819153528.GA21357@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

I've been trying to finally get rid of the last users of setools3 since
its basically on life support. I have a lot of things fixed locally but
not quite in good enough shape to submit.

Sepolicy currently is the thing that uses setools3 and everything else
mostly goes via sepolicy. It boils down to sepolicy.info() and
sepolicy.search() which are C-wrappers to setools3. Those two methods
have a very open-ended and confusing API, and are just very thin
wrappers around setools. It seems to me that we'd be better off updating
most things that use it to instead use setools4 directly.

I have fixed .info() already (although still untested) so .search() is
the main problem. It takes dictionaries of stuff and returns
dictionaries of stuff and what exactly is in the dictionaries is not
that clear.

How many users outside of the tree are there for sepolicy directly? If
the only users are in the tree, I'd much rather kill off
sepolicy.search() and go directly to setools. Is that an option?

slawrence mentioned on IRC that setroubleshoot might use sepolicy but
wasnt entirely sure. Even if it does, does it use .search() and .info()?
or does it only use all the other methods from it?

-- Jason
