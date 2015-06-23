Message-ID: <55899EF8.6050301@tycho.nsa.gov>
Date: Tue, 23 Jun 2015 14:01:28 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux-testsuite: fix unix/inet socket tests
References: <1435005608-25931-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhS-tEMTDaRpxM+aTANagvXX+RUSCfoqaEBQrEjXpfWuGA@mail.gmail.com>
 <55895572.7030509@tycho.nsa.gov>
 <CAHC9VhRFc=ff+YOKSL7Lbf5kCcbPJg_66Xv5boozqKDj+KRUsw@mail.gmail.com>
 <5589957C.6070506@tycho.nsa.gov>
 <CAHC9VhQX9RQ05Q3qSPPQis2C2STYPVHQ2V3eg+-syV4WtF7M+g@mail.gmail.com>
In-Reply-To: <CAHC9VhQX9RQ05Q3qSPPQis2C2STYPVHQ2V3eg+-syV4WtF7M+g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/23/2015 01:33 PM, Paul Moore wrote:
> On Tue, Jun 23, 2015 at 1:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> I don't suppose those tests are open source and available somewhere?
> 
> Of course ...
> 
>  * https://sourceforge.net/projects/audit-test
> 
> Minor disclaimer: I wrote those network tests under a time crunch,
> they certainly could be done better, but they work(ed) ;)

I'm probably just blind, but I don't see any side channel there, just
timeouts and such.  If you're ok with that, then my version 2 patch
should be good to go.
