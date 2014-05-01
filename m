Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41E1pS6031680
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 10:01:51 -0400
Message-ID: <536253C4.4020602@tresys.com>
Date: Thu, 1 May 2014 10:01:40 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <535FBE4F.7020501@tresys.com>	
 <1398947912.19535.7.camel@x220.localdomain> <536244D1.70102@tresys.com>	
 <1398950672.19535.12.camel@x220.localdomain>	
 <1398950868.19535.14.camel@x220.localdomain>
 <1398951093.19535.15.camel@x220.localdomain>
In-Reply-To: <1398951093.19535.15.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/01/2014 09:31 AM, Dominick Grift wrote:
> On Thu, 2014-05-01 at 15:27 +0200, Dominick Grift wrote:
>> On Thu, 2014-05-01 at 15:24 +0200, Dominick Grift wrote:
>>
>> Whoops sorry... Its called by an unused type attribute
>>
>> Sorry for the noise
> 
> hmm.. no i think its really a bug... it should be there
> 

Ugh, we were missing a break statement in the --handle-unknown case of
secilc, so it fell through to the dontaudit case. So using the -U option
caused dontaudits to be disabled. Below is a patch that should fix it.

Thanks,
- Steve

diff --git a/secilc.c b/secilc.c
index 88a9cfa..2b95875 100644
--- a/secilc.c
+++ b/secilc.c
@@ -156,6 +156,7 @@ int main(int argc, char *argv[])
                } else {
                    usage(argv[0]);
                }
+               break;
            case 'D':
                disable_dontaudit = 1;
                break;
