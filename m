Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38G5ufv020952
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 12:06:00 -0400
Received: by mail-pa0-f65.google.com with SMTP id hb4so9370037pac.1
 for <selinux@tycho.nsa.gov>; Fri, 08 Apr 2016 09:05:58 -0700 (PDT)
Received: from localhost ([2404:e800:e600:38b:5121:e6bd:6ddf:d757])
 by smtp.gmail.com with ESMTPSA id m10sm19700078pfi.32.2016.04.08.09.05.55
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Apr 2016 09:05:56 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: genhomedircon USERID and USERNAME patches
Date: Sat,  9 Apr 2016 00:05:28 +0800
Message-Id: <1460131535-15688-1-git-send-email-jason@perfinion.com>
In-Reply-To: <20160201093633.GB21978@meriadoc.perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

I finally finished adding more templates to genhomedircon and a lot of general
cleanups.

The first few patches refactor the templating functions so they are smaller and
easier to add new. All the common bits were taken out and they all take the
user_entry_t struct instead of passing args one by one.

The last three patches add the new templating types. I went with %{USERID} and
%{USERNAME}. They now have a clear start and end unlike USER in the past and $
is end of line in regexes so % seems safer. The matcher for USER now
specifically excludes any line that has the new patterns in it too so there can
be no conflict. It appears to work in the testing I have done with adding
strange fcontexts. make test passes in the repo too but i have not run the full
selinux-testsuite.

%{USERNAME} defaults to ".*" in the fallback just like USER originally did
%{USERID} defaults to "[0-9]+" for the fallback.

Another thing I noticed was that HOME_DIR's fallback is "[^/]*", should it be +
instead of *? I dont think it makes a huge difference because then it should
match HOME_ROOT but it still seems wrong.

-- Jason
