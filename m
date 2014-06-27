Message-ID: <53AD6072.6070608@tycho.nsa.gov>
Date: Fri, 27 Jun 2014 08:15:46 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: Fwd: Booting time is increased after applying kernel 3.10
References: <CAEFn6A4mzF208e1s_OHEzJ-1Kq-DUGgzVNbQXrW6NbB0e8DSpQ@mail.gmail.com>
 <CAB9W1A2VnkCh3ru7ZKST0e55DnpMxPEbzDdczwDY7o0tsZdjnw@mail.gmail.com>
 <53AC26E5.2040006@tycho.nsa.gov> <3505220.0Xdb07vFt3@sifl>
In-Reply-To: <3505220.0Xdb07vFt3@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jaejyn Shin <flagon22bass@gmail.com>, selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/26/2014 10:17 AM, Paul Moore wrote:
> On Thursday, June 26, 2014 09:57:57 AM Stephen Smalley wrote:
>> On 06/25/2014 03:49 PM, Stephen Smalley wrote:
>>> I suspect it won't matter in practice, but the reason for it is that
>>> permissions or other state may have been cached during bootup prior to
>>> initial policy load that may no longer be valid.
> 
> ...
> 
>> So I am not sure we can safely remove the avc_ss_reset() from initial
>> policy load in the mainline kernel, as we are not guaranteed that there
>> is no network interface configuration prior to initial policy load and
>> we are not guaranteed that there will be a setenforce 1.  It would
>> perhaps be better there to instead just avoid calling synchronize_net
>> altogether if possible or only call it once for the entire avc_ss_reset,
>> not on each of the netif/node/port callbacks.
> 
> When I took a quick glance at this briefly yesterday one of the things that 
> crossed my mind was exporting the different netif/node/port flush functions 
> and grouping the callbacks into a single callback that calls each of the flush 
> functions and then synchronize_net() once at the end; similar to what you 
> describe above.  Perhaps that is the best solution upstream.
> 
> Unless someone else wants to develop/test a patch, I'll put one together.

Did you confirm that we need the synchronize_net() call at all?
