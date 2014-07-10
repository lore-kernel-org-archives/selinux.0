Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6AFtkZi021647
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 11:55:46 -0400
Received: by mail-pd0-f169.google.com with SMTP id ft15so4256917pdb.14
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 08:55:39 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.177.238])
 by mx.google.com with ESMTPSA id vr9sm69512623pab.6.2014.07.10.08.55.38
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 10 Jul 2014 08:55:39 -0700 (PDT)
Message-ID: <53BEB778.5000103@gmail.com>
Date: Thu, 10 Jul 2014 21:25:36 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a 'permission map'?
References: <53BB794B.7070206@gmail.com> <53BBE2CB.4000903@tresys.com>
In-Reply-To: <53BBE2CB.4000903@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/08/14 17:53, Christopher J. PeBenito wrote:
> On 7/8/2014 12:53 AM, dE wrote:
>> This seems to be required by apol sometimes. Loading the default policy
>> as the permission map works, but what is permission map?
> In apol, it is required by an information flow analysis.  A permission
> map describes each permission in the policy as an abstract "read",
> "write", "both", or "none" information flow permission used in the
> analysis.  The apol help text has a full description of information flow
> analysis and the permission map (Help->Information Flow Analysis).
>

So a permission map is basically a high level abstraction for various 
classes of permissions so apol can present the information flow between 
types.
