Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4FHh7AE018627
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2014 13:43:07 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so1359623pab.17
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2014 10:43:07 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.86.137])
 by mx.google.com with ESMTPSA id sh5sm10175028pbc.21.2014.05.15.10.43.05
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 15 May 2014 10:43:06 -0700 (PDT)
Message-ID: <5374FC0B.1080804@gmail.com>
Date: Thu, 15 May 2014 23:10:27 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Presidency of user/role/type permissions.
References: <5371EA55.703@gmail.com> <53720F8C.8000205@tresys.com>
 <5372239D.3010007@redhat.com> <53730743.1050900@gmail.com>
 <537308E1.4050705@gmail.com> <53736433.1030107@redhat.com>
In-Reply-To: <53736433.1030107@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/14 18:10, Daniel J Walsh wrote:
> As far as roles/type combinations, most system roles get assigned the
> system_r role.  This is the vast majority of role/type combination.
>   seinfo -rsystem_r -x | wc -l
> 776
>
> User roles are assigned based on the _run interfaces, and are built into
> higher level interfaces to get assigned automatically when you define a
> new user_r as a user.
>
> seinfo -ruser_r -x | wc -l
> 175
> seinfo -rguest_r -x | wc -l
> 95

Since the role has a set of allowed type it acts as an abstraction 
between a new user and the types; simply assigning a user a certain role 
is enough to define the allowed types a process can have under the user.

Since I don't know M4 macros, I would request you to clarify 1 more 
question -- when a new type is defined, the macros are used to define 
which roles will this new type be allowed in? Or is it the other way 
around -- the definition of one of the role is modified so as to include 
this new type?
