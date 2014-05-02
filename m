Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s426XXeI003228
 for <selinux@tycho.nsa.gov>; Fri, 2 May 2014 02:33:33 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so4632579ieb.41
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 23:33:33 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.16.173])
 by mx.google.com with ESMTPSA id qd9sm2075084igb.12.2014.05.01.23.33.31
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 01 May 2014 23:33:33 -0700 (PDT)
Message-ID: <53633B9F.7010307@gmail.com>
Date: Fri, 02 May 2014 12:00:55 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a policy configuration file?
References: <53627C9F.9020109@gmail.com>	
 <CAB9W1A1+Rh0hDW+dNzehTbo0p4r-vaGWdugks9UnfNoZ5xuinQ@mail.gmail.com>	
 <53628456.8020407@gmail.com> <1398966664.19535.20.camel@x220.localdomain>
In-Reply-To: <1398966664.19535.20.camel@x220.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/01/14 23:21, Dominick Grift wrote:
> On Thu, 2014-05-01 at 22:58 +0530, dE wrote:
>
>> http://www.nsa.gov/research/_files/selinux/papers/policy2/x109.shtml
>>
>> http://selinuxproject.org/page/ConfigurationFiles#Policy_Configuration_Files
>>
>> I would like to know what the official website means -- it's definitely
>> the sources. I hope I'll read about policy.conf in the NSA reference.
> I suppose it can have various meanings depending on the context in which
> the term is used.
>
> Policy IS configuration, and so any file with policy in it in any format
> could be referred to as "policy configuration" file
>
> Then there are the configuration files that are distributed with the
> policy configuration. I suppose technically those are "policy
> configuration" configuration files.
>
> There there is often also a configuration files that specifies the
> options with which a policy configuration is compiled, and so i suppose
> one could also refer to that file as a "policy configuration"
> configuration file.
>
> Welcome to the wonderful world of SELinux terminology!
>

I've never read about the config in para 3.

As of the termionogy -- I'm sure the policy source file should be called 
policy source not 'policy config' for the same reason as C/C++ source 
files are called the source.
