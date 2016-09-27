Subject: Re: [Patch v3] sandbox: Use dbus-run-session instead of dbus-launch
 when available
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20160927123949.24440-1-bigon@debian.org>
 <86f0359d-ff64-4f68-9899-c1219b30bfeb@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <a4570e73-8be1-e557-9f60-7319d2219da4@debian.org>
Date: Tue, 27 Sep 2016 15:49:31 +0200
MIME-Version: 1.0
In-Reply-To: <86f0359d-ff64-4f68-9899-c1219b30bfeb@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 27/09/16 à 15:50, Stephen Smalley a écrit :
> On 09/27/2016 08:39 AM, Laurent Bigonville wrote:
>> From: Laurent Bigonville <bigon@bigon.be>
>>
>> According to dbus upstream: "dbus-launch is fairly horrible code,
>> complicated by the historical need for it to support X11 autolaunching,
>> so the D-Bus maintainers would like to move it out of the critical path
>> and minimize its use."
>>
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=836289
>>
>> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> Thanks, applied.
Thanks,

Are there any plans to roll a new release of the userspace soon?
