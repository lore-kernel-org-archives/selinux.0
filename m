Message-ID: <55479132.5000809@tresys.com>
Date: Mon, 4 May 2015 11:33:06 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: secilc bug
References: <CAHC9VhQu=U51b85U74xhP+x+4VCOrm9W8WVAw=vW6s0FdSNPxw@mail.gmail.com>
 <alpine.LRH.2.11.1504131142390.774@namei.org>
 <CAHC9VhSAVxo2wkOpMj1QcM-=HvBVhOvVGyTG-JGQHKJhn-rvYw@mail.gmail.com>
 <alpine.LRH.2.11.1504241023280.13918@namei.org>
 <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
 <553A6D3D.8020904@schaufler-ca.com>
 <CAHC9VhQkYU990OKAySUnPn-XzoOUN=21AjOB76pbM7uVQX_0xQ@mail.gmail.com>
 <alpine.LRH.2.11.1504271528350.16342@namei.org>
 <1430265211.2218.13.camel@linux.vnet.ibm.com> <20150502150259.GA15244@x131e>
 <20150503105045.GB13244@x131e> <55478E17.8040609@tycho.nsa.gov>
In-Reply-To: <55478E17.8040609@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="------------060308000904040907030105"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--------------060308000904040907030105
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 05/04/2015 11:19 AM, James Carter wrote:
> On 05/03/2015 06:50 AM, Dominick Grift wrote:
>> On Sat, May 02, 2015 at 05:02:59PM +0200, Dominick Grift wrote:
>>> Today i hit an bug in secilc, when compiled by policy with some
>>> modules excluded.
>>
>> <snip>
>>
>> I suspect the issue is something like the following:
>>
>> There are currently no rules associated with the
>> pam_auth_config_object_type type attribute thus it will be removed
>> from the policy by secilc
>>
>> However this may or may not change. I do have macros with rules assoc.
>> with pam_auth_config_object_type, they are currently just not called
>> by anything
>>
>> In my policy, the pam_auth_config_object_type type attribute currently
>> only acts as a bridge to auth_object_type type attribute
>>
>> Example: pam_config_t (and many other types) is/are assoc. with
>> auth_pam_config_object_type, auth_pam_config_object_type is associated
>> with auth_object_type, and there are rules assoc. with auth_object_type
>>
>> (for example: auth_admin_subject_type auth_object_type
>> (all_file_objects (all_file_perms_except)))
>>
>> The question remains, how does me exluding the xserver.cil affects all
>> this. I actually commented out the only call to
>> the auth.cil module ( (call auth_pam_config_object_type
>> (xserver_pam_config_t)) ) from the xserver module and it turns out to not
>> affect it. So it is not that macro call.
>>
>> It may instead be another ordering issue...
>>
> 
> There doesn't seem to be ordering issues related to typeattributeset
> statements. See attached test policy if you're interested.
> 
>> E.g. excluding the xserver.cil module may mess up the ordering of the
>> modules to process in such a way that this rule vanishes
>>
>> Because that is what this issue boils down to: rules vanishing for no
>> reason
>>
>> I made a screencast that tries to explain the issue:
>>
>> https://www.youtube.com/watch?v=XRp5z9aqLDo
>>
>>
> 
> I think that it would be more helpful to me if I could see the policy.
> Is it available anywhere? If not, could you send me at least the
> auth.cil and xserver.cil modules?
> 

I think this might be a reset issue, with classmappings or something
related to classmappings not getting reset/re-resolved correctly. I've
noticed that with xserver.cil removed, some optional fails and causes a
re-resolve. Then when writing to the binary, the allow rule mentioned
ends up with all perms being empty, and so the allow rule is never added.

Note I also needed to modify EXCLUDE to exclude a handful of files due
to dependencies with xserver. I've attached that file.

- Steve

--------------060308000904040907030105
Content-Type: text/plain; charset="UTF-8"; name="EXCLUDE"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="EXCLUDE"

tests/
sources/modules/contrib/applications/setbacklight.cil
sources/modules/contrib/applications/b43fwcutter.cil
sources/modules/contrib/services/bluetooth.cil
sources/modules/contrib/system/myqemu.cil
sources/modules/contrib/system/tunctl.cil
sources/modules/contrib/system/bridgeutil.cil
sources/modules/contrib/applications/firefox.cil
sources/modules/contrib/applications/qiv.cil
sources/modules/contrib/applications/xpdf.cil
sources/modules/contrib/applications/xutil.cil
sources/modules/contrib/applications/dunst.cil
sources/modules/contrib/applications/xlock.cil
sources/modules/contrib/applications/xterm.cil
sources/modules/contrib/applications/xbindkeys.cil
sources/modules/contrib/applications/rp.cil
sources/modules/contrib/applications/dbuslaunch.cil
sources/modules/contrib/applications/ffmpeg.cil
sources/modules/contrib/applications/mplayer.cil
sources/modules/contrib/applications/cowsay.cil
sources/modules/contrib/applications/atspi2.cil

--------------060308000904040907030105--
