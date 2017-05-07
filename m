Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47FM8O7010982
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 11:22:09 -0400
Received: by mail-qk0-f171.google.com with SMTP id u75so35713961qka.3
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 08:22:05 -0700 (PDT)
Received: from strange.local (50-253-7-1-static.hfc.comcastbusiness.net.
 [50.253.7.1])
 by smtp.googlemail.com with ESMTPSA id t1sm7959874qte.67.2017.05.07.08.22.03
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 May 2017 08:22:03 -0700 (PDT)
Message-ID: <590F3B98.406@quarksecurity.com>
Date: Sun, 07 May 2017 11:22:00 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius>
In-Reply-To: <20170506171920.GB20145@julius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dominick Grift wrote:
<snip>

> The idea is nice, unfortunately its inflexible and it has hard-references to reference policy all-over. It has potential but it is still rough.
>

Of course, it is an analysis of a refpolicy-based policy. If you want to 
analyze a different policy (e.g., Android or home-rolled) you will have 
to change out all of the type sets, etc.

You can't make a magic generic analysis script without knowing how key 
parts of the system work and what types are associated with those 
components.
