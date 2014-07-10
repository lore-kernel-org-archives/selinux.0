Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6AGCQvS023175
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 12:12:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so11391948pac.33
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 09:12:26 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.177.238])
 by mx.google.com with ESMTPSA id kq10sm62327203pbc.90.2014.07.10.09.12.25
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 10 Jul 2014 09:12:26 -0700 (PDT)
Message-ID: <53BEBB67.8040804@gmail.com>
Date: Thu, 10 Jul 2014 21:42:23 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a 'permission map'?
References: <53BB794B.7070206@gmail.com>
 <1404822463.29866.YahooMailNeo@web87901.mail.ir2.yahoo.com>
In-Reply-To: <1404822463.29866.YahooMailNeo@web87901.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/08/14 17:57, Richard Haines wrote:
> This file is only required when using the "Analysis" tab features. It is fully described
> in the "Help" - "Information Flow Analysis" tab.
>
>
> APOL will try to find a default in your home directory called .apol_perm_mapping
>
> There are various versions in usr/share/setools-3.3 (apol_perm_mapping_*). Best to
> select the latest one and copy to home dir as .apol_perm_mapping to stop it
> complaining.
>
> It will be loaded when you do the first analysis, and can then be modified using
> "Tools - "View Perm Map".
>
>
>
> ----- Original Message -----
>> From: dE <de.techno@gmail.com>
>> To: selinux@tycho.nsa.gov
>> Cc:
>> Sent: Tuesday, 8 July 2014, 5:53
>> Subject: What's a 'permission map'?
>>
>> T his seems to be required by apol sometimes. Loading the default policy
>> as the permission map works, but what is permission map?
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>

After reading these file I've realized that a permission map is 
basically a map of various permissions of various classes to a high 
level r/w/n/b.

Next apol has to convert allow statements in the loaded policy which 
contain class specific permissions to a high level r/w/n/b set of 
permission between types.

But what does apol do when I just feed it the binary policy instead of a 
real permission map?
