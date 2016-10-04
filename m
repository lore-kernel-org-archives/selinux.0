Subject: Re: [PATCH 2/2] libselinux: query for python site-packages dir
 directly
To: Nicolas Iooss <nicolas.iooss@m4x.org>, Jason Zaman <jason@perfinion.com>,
 selinux@tycho.nsa.gov, Laurent Bigonville <bigon@debian.org>
References: <1475381714-9906-1-git-send-email-jason@perfinion.com>
 <1475381714-9906-2-git-send-email-jason@perfinion.com>
 <fa22ce21-3ec2-485c-c0c0-499bff50792d@tycho.nsa.gov>
 <e7b6a5b3-1115-a216-eba4-c1fe787f4203@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <91e48a15-5fe8-b7d3-57d4-efce75594369@tycho.nsa.gov>
Date: Tue, 4 Oct 2016 10:23:53 -0400
MIME-Version: 1.0
In-Reply-To: <e7b6a5b3-1115-a216-eba4-c1fe787f4203@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/03/2016 04:10 PM, Nicolas Iooss wrote:
> On 03/10/16 15:35, Stephen Smalley wrote:
>> On 10/02/2016 12:15 AM, Jason Zaman wrote:
>>> instead of building the path manually which is more error prone
>>
>> Thanks, applied both.  I guess the only question I have is whether a)
>> this same change ought to be applied to all other Makefiles (e.g.
>> libsemanage, policycoreutils), and b) could this break any existing
>> build recipes that relied on setting PYLIBDIR.  Doesn't appear that
>> Fedora spec files do so, but not sure about other distribution packages.
> 
> For the second question, ArchLinux packages will not break. I quickly
> looked at the Debian packages and it appears libselinux is using
> PYLIBDIR [1] but not libsemanage [2]. Also the Debian packages appear to
> install the Python module into /usr/lib/python.../dist-packages instead
> of the site-packages directory. I am wondering whether this may be
> important.
> 
> Nicolas
> 
> [1]
> https://anonscm.debian.org/cgit/selinux/libselinux.git/tree/debian/python.mk
> [2] https://anonscm.debian.org/cgit/selinux/libsemanage.git/
> [3] https://packages.debian.org/sid/amd64/python3-selinux/filelist
> [4] https://packages.debian.org/sid/amd64/python3-semanage/filelist

(cc Debian selinux maintainer)
