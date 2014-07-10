Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6AGtD4Z026835
 for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2014 12:55:13 -0400
Message-ID: <53BEC557.7060409@tresys.com>
Date: Thu, 10 Jul 2014 12:54:47 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: What's a 'permission map'?
References: <53BB794B.7070206@gmail.com>
 <1404822463.29866.YahooMailNeo@web87901.mail.ir2.yahoo.com>
 <53BEBB67.8040804@gmail.com>
In-Reply-To: <53BEBB67.8040804@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/10/2014 12:12 PM, dE wrote:
> On 07/08/14 17:57, Richard Haines wrote:
>> This file is only required when using the "Analysis" tab features. It
>> is fully described
>> in the "Help" - "Information Flow Analysis" tab.
>>
>>
>> APOL will try to find a default in your home directory called
>> .apol_perm_mapping
>>
>> There are various versions in usr/share/setools-3.3
>> (apol_perm_mapping_*). Best to
>> select the latest one and copy to home dir as .apol_perm_mapping to
>> stop it
>> complaining.
>>
>> It will be loaded when you do the first analysis, and can then be
>> modified using
>> "Tools - "View Perm Map".
>>
> After reading these file I've realized that a permission map is
> basically a map of various permissions of various classes to a high
> level r/w/n/b.
> 
> Next apol has to convert allow statements in the loaded policy which
> contain class specific permissions to a high level r/w/n/b set of
> permission between types.
> 
> But what does apol do when I just feed it the binary policy instead of a
> real permission map?

It always uses the abstract r/w/n/b permissions for the information flow
analysis.  The permission map is only used in the information flow
analysis, which is why tools like sesearch don't have permission map
options.  If you run an information flow analysis without explicitly
loading a permission map, apol will try to load one, like Richard
describes above, so that the analysis can be performed.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
