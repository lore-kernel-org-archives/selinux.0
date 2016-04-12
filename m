Subject: Re: genhomedircon USERID and USERNAME patches
To: Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Iooss <nicolas.iooss@m4x.org>,
 Jason Zaman <jason@perfinion.com>, selinux <selinux@tycho.nsa.gov>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
 <570CF09E.10100@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <570D079B.40106@tresys.com>
Date: Tue, 12 Apr 2016 10:35:07 -0400
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
In-Reply-To: <570CF09E.10100@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/12/2016 8:57 AM, Stephen Smalley wrote:
> On 04/11/2016 05:44 PM, Nicolas Iooss wrote:
>> On Fri, Apr 8, 2016 at 6:05 PM, Jason Zaman <jason@perfinion.com
>> <mailto:jason@perfinion.com>> wrote:

>> By the way, by grep'ing HOME_DIR in refpolicy I got a hit in a support
>> script, "support/genhomedircon" [1]. This script is invoked only when
>> building modular policy and I have not found an easy way to
>> invoke semanage_genhomedircon() from either the command line or a Python
>> script. Does this script needs to be updated or is there a way to use
>> libsemanage implementation instead?

>> [1] https://github.com/TresysTechnology/refpolicy/blob/master/support/genhomedircon
> 
> I believe the script is obsolete under modular policy (only used on
> monolithic builds), and you can trigger semanage_genhomedircon() just by
> running semodule -Bn.  /usr/sbin/genhomedircon is a symlink to semodule,
> and semodule runs as if invoked with -Bn when called under that name.

Right, the script that refpolicy has is only used on monolithic builds.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
