Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t44FKDaG016066
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 11:20:13 -0400
Message-ID: <55478E17.8040609@tycho.nsa.gov>
Date: Mon, 04 May 2015 11:19:51 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
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
 <20150503105045.GB13244@x131e>
In-Reply-To: <20150503105045.GB13244@x131e>
Content-Type: multipart/mixed; boundary="------------030206090404060804000307"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------030206090404060804000307
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2015 06:50 AM, Dominick Grift wrote:
> On Sat, May 02, 2015 at 05:02:59PM +0200, Dominick Grift wrote:
>> Today i hit an bug in secilc, when compiled by policy with some modules excluded.
>
> <snip>
>
> I suspect the issue is something like the following:
>
> There are currently no rules associated with the pam_auth_config_object_type type attribute thus it will be removed from the policy by secilc
>
> However this may or may not change. I do have macros with rules assoc. with pam_auth_config_object_type, they are currently just not called by anything
>
> In my policy, the pam_auth_config_object_type type attribute currently only acts as a bridge to auth_object_type type attribute
>
> Example: pam_config_t (and many other types) is/are assoc. with auth_pam_config_object_type, auth_pam_config_object_type is associated
> with auth_object_type, and there are rules assoc. with auth_object_type
>
> (for example: auth_admin_subject_type auth_object_type (all_file_objects (all_file_perms_except)))
>
> The question remains, how does me exluding the xserver.cil affects all this. I actually commented out the only call to
> the auth.cil module ( (call auth_pam_config_object_type (xserver_pam_config_t)) ) from the xserver module and it turns out to not
> affect it. So it is not that macro call.
>
> It may instead be another ordering issue...
>

There doesn't seem to be ordering issues related to typeattributeset statements. 
See attached test policy if you're interested.

> E.g. excluding the xserver.cil module may mess up the ordering of the modules to process in such a way that this rule vanishes
>
> Because that is what this issue boils down to: rules vanishing for no reason
>
> I made a screencast that tries to explain the issue:
>
> https://www.youtube.com/watch?v=XRp5z9aqLDo
>
>

I think that it would be more helpful to me if I could see the policy. Is it 
available anywhere? If not, could you send me at least the auth.cil and 
xserver.cil modules?


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--------------030206090404060804000307
Content-Type: application/vnd.ms-artgalry;
 name="test.cil"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.cil"

KGNsYXNzIENMQVNTIChQRVJNKSkKKGNsYXNzb3JkZXIgKENMQVNTKSkKKHNpZCBTSUQpCihz
aWRvcmRlciAoU0lEKSkKKHVzZXIgVVNFUikKKHJvbGUgUk9MRSkKKHR5cGUgVFlQRSkKKGNh
dGVnb3J5IENBVCkKKGNhdGVnb3J5b3JkZXIgKENBVCkpCihzZW5zaXRpdml0eSBTRU5TKQoo
c2Vuc2l0aXZpdHlvcmRlciAoU0VOUykpCihzZW5zaXRpdml0eWNhdGVnb3J5IFNFTlMgKENB
VCkpCihhbGxvdyBUWVBFIHNlbGYgKENMQVNTIChQRVJNKSkpCihyb2xldHlwZSBST0xFIFRZ
UEUpCih1c2Vycm9sZSBVU0VSIFJPTEUpCih1c2VybGV2ZWwgVVNFUiAoU0VOUykpCih1c2Vy
cmFuZ2UgVVNFUiAoKFNFTlMpKFNFTlMgKENBVCkpKSkKKHNpZGNvbnRleHQgU0lEIChVU0VS
IFJPTEUgVFlQRSAoKFNFTlMpKFNFTlMpKSkpCgo7OyAtLSBDYXNlIDEgLS0KKHR5cGUgdDFh
KQoodHlwZSB0MWIpCih0eXBlIHQxYykKKHR5cGVhdHRyaWJ1dGUgYTFhKQoodHlwZWF0dHJp
YnV0ZXNldCBhMWEgKHQxYSkpCih0eXBlYXR0cmlidXRlIGExYikKKHR5cGVhdHRyaWJ1dGVz
ZXQgYTFiICh0MWIgYTFhKSkKKHR5cGVhdHRyaWJ1dGUgYTFjKQoodHlwZWF0dHJpYnV0ZXNl
dCBhMWMgKHQxYyBhMWIpKQooYWxsb3cgYTFjIFRZUEUgKENMQVNTIChQRVJNKSkpCgo7OyAt
LSBDYXNlIDIgLS0gTGlrZSBDYXNlIDEgd2l0aCBkaWZmZXJlbnQgb3JkZXJpbmcKKHR5cGUg
dDJhKQoodHlwZSB0MmIpCih0eXBlIHQyYykKKHR5cGVhdHRyaWJ1dGUgYTJjKQoodHlwZWF0
dHJpYnV0ZXNldCBhMmMgKHQyYyBhMmIpKQoodHlwZWF0dHJpYnV0ZSBhMmIpCih0eXBlYXR0
cmlidXRlc2V0IGEyYiAodDJiIGEyYSkpCih0eXBlYXR0cmlidXRlIGEyYSkKKHR5cGVhdHRy
aWJ1dGVzZXQgYTJhICh0MmEpKQooYWxsb3cgYTJjIFRZUEUgKENMQVNTIChQRVJNKSkpCgo7
OyAtLSBDYXNlIDMgLS0gTm93IHB1dCB0eXBlYXR0cmlidXRlc2V0IHN0YXRlbWVudHMgaW4g
YSBtYWNybwoodHlwZSB0M2EpCih0eXBlIHQzYikKKHR5cGUgdDNjKQoodHlwZWF0dHJpYnV0
ZSBhM2EpCihtYWNybyBhZGQzYSAoKHR5cGUgdCkpCiAgICAgICAodHlwZWF0dHJpYnV0ZXNl
dCBhM2EgdCkKKQoodHlwZWF0dHJpYnV0ZSBhM2IpCihtYWNybyBhZGQzYiAoKHR5cGUgdCkp
CiAgICAgICAodHlwZWF0dHJpYnV0ZXNldCBhM2IgdCkKKQoodHlwZWF0dHJpYnV0ZSBhM2Mp
CihtYWNybyBhZGQzYyAoKHR5cGUgdCkpCiAgICAgICAodHlwZWF0dHJpYnV0ZXNldCBhM2Mg
dCkKKQooY2FsbCBhZGQzYSAodDNhKSkKKGNhbGwgYWRkM2IgKGEzYSkpCihjYWxsIGFkZDNi
ICh0M2IpKQooY2FsbCBhZGQzYyAoYTNiKSkKKGNhbGwgYWRkM2MgKHQzYykpCihhbGxvdyBh
M2MgVFlQRSAoQ0xBU1MgKFBFUk0pKSkKCjs7IC0tIENhc2UgNCAtLSBMaWtlIENhc2UgMyBi
dXQgd2l0aCBhIGRpZmZlcmVudCBvcmRlcmluZwoodHlwZSB0NGEpCih0eXBlIHQ0YikKKHR5
cGUgdDRjKQoodHlwZWF0dHJpYnV0ZSBhNGMpCihtYWNybyBhZGQ0YyAoKHR5cGUgdCkpCiAg
ICAgICAodHlwZWF0dHJpYnV0ZXNldCBhNGMgdCkKKQoodHlwZWF0dHJpYnV0ZSBhNGEpCiht
YWNybyBhZGQ0YSAoKHR5cGUgdCkpCiAgICAgICAodHlwZWF0dHJpYnV0ZXNldCBhNGEgdCkK
KQoodHlwZWF0dHJpYnV0ZSBhNGIpCihtYWNybyBhZGQ0YiAoKHR5cGUgdCkpCiAgICAgICAo
dHlwZWF0dHJpYnV0ZXNldCBhNGIgdCkKKQooY2FsbCBhZGQ0YyAoYTRiKSkKKGNhbGwgYWRk
NGIgKGE0YSkpCihjYWxsIGFkZDRhICh0NGEpKQooY2FsbCBhZGQ0YiAodDRiKSkKKGNhbGwg
YWRkNGMgKHQ0YykpCihhbGxvdyBhNGMgVFlQRSAoQ0xBU1MgKFBFUk0pKSkK
--------------030206090404060804000307--
