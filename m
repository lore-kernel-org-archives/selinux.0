Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0N3aqSi026939
 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2014 22:36:52 -0500
Received: by mail-qc0-f182.google.com with SMTP id c9so1799272qcz.13
 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2014 19:36:37 -0800 (PST)
Message-ID: <52E08E43.1000109@quarksecurity.com>
Date: Wed, 22 Jan 2014 22:36:35 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Victor Porton <porton@narod.ru>
Subject: Re: There should be multiple MLS
References: <363761390445810@web24h.yandex.ru>
In-Reply-To: <363761390445810@web24h.yandex.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Victor Porton wrote:
> There should be multiple MLSes:
>
> For example, one MLS for classified documents degrees and yet one MLS for different complexity of software (and qualification of an employee using this software).
>

MLS is used when there needs to be a hierarchical relationship (i.e., 
classification) but, in general, SELinux uses type enforcement for 
integrity and role separation.

For example, various daemons, even running at the same classification, 
would have different types (httpd_t, mysql_t, etc) and would be 
restricted to only their necessary access.
