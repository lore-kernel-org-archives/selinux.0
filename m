Message-ID: <4BB36B92.8010704@tycho.nsa.gov>
Date: Wed, 31 Mar 2010 11:34:42 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Add implicit lib requirements to LDLIBS
References: <1269983319-10453-1-git-send-email-jbrindle@tresys.com> <4BB28AA1.9060508@tycho.nsa.gov> <4BB34C5C.7030309@tresys.com>
In-Reply-To: <4BB34C5C.7030309@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------020503060107040505080908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020503060107040505080908
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/31/2010 09:21 AM, Joshua Brindle wrote:
> Eamon Walsh wrote:
>   
>> On 03/30/2010 05:08 PM, Joshua Brindle wrote:
>>     
>>> Fedora 13 changed their linker behavior to not link indirect libraries.
>>> See information at: http://fedoraproject.org/wiki/UnderstandingDSOLinkChange
>>>
>>>       
>> I skimmed over semodule.c and setsebool.c and I didn't see any
>> references to bzip2 or ustr symbols.  My reading of the article suggests
>> the below fix should only be needed if that were the case.  Most likely
>> I missed them?
>>
>>     
> The link above is confusing. The change was made so that people who 
> _did_ use eg., libxml but didn't explicitly link against it would have 
> to do so even if other libraries they link against already did.
>
> In our case it means that anything libsemanage needs semodule and 
> setsebool will also need to link against explicitly.
>   

I'm still not seeing that anywhere in the discussion.  As far as I can
see, libraries are still supposed to pull in their own dependencies. 
Putting -lustr -lbz2 on the program build line should only be necessary
if the program source itself uses them, which semodule doesn't seem to. 
I think something's fishy in our build.

Take the following gtk2 program (attached).  I can successfully build
and run this program on rawhide just by linking with gtk2, even though
gtk2 has a ton of other libraries that it needs:

# gcc -I /usr/include/atk-1.0 -I /usr/include/pango-1.0 -I
/usr/include/cairo -I /usr/include/gtk-2.0 -I /usr/lib/gtk-2.0/include
-I /usr/include/glib-2.0 -I /usr/lib/glib-2.0/include -o gtkhelloworld
gtkhelloworld.c -lgtk-x11-2.0
#




-- 

Eamon Walsh 
National Security Agency


--------------020503060107040505080908
Content-Type: text/plain;
 name="gtkhelloworld.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gtkhelloworld.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxndGsvZ3RrLmg+CgovKiBUaGlzIGlzIGEg
Y2FsbGJhY2sgZnVuY3Rpb24uIFRoZSBkYXRhIGFyZ3VtZW50cyBhcmUgaWdub3JlZAogKiBp
biB0aGlzIGV4YW1wbGUuIE1vcmUgb24gY2FsbGJhY2tzIGJlbG93LiAqLwpzdGF0aWMgdm9p
ZCBoZWxsbyggR3RrV2lkZ2V0ICp3aWRnZXQsCiAgICAgICAgICAgICAgICAgICBncG9pbnRl
ciAgIGRhdGEgKQp7CiAgICBwcmludGYgKCJIZWxsbyBXb3JsZFxuIik7Cn0KCnN0YXRpYyBn
Ym9vbGVhbiBkZWxldGVfZXZlbnQoIEd0a1dpZGdldCAqd2lkZ2V0LAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBHZGtFdmVudCAgKmV2ZW50LAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBncG9pbnRlciAgIGRhdGEgKQp7CiAgICAvKiBJZiB5b3UgcmV0dXJuIEZB
TFNFIGluIHRoZSAiZGVsZXRlX2V2ZW50IiBzaWduYWwgaGFuZGxlciwKICAgICAqIEdUSyB3
aWxsIGVtaXQgdGhlICJkZXN0cm95IiBzaWduYWwuIFJldHVybmluZyBUUlVFIG1lYW5zCiAg
ICAgKiB5b3UgZG9uJ3Qgd2FudCB0aGUgd2luZG93IHRvIGJlIGRlc3Ryb3llZC4KICAgICAq
IFRoaXMgaXMgdXNlZnVsIGZvciBwb3BwaW5nIHVwICdhcmUgeW91IHN1cmUgeW91IHdhbnQg
dG8gcXVpdD8nCiAgICAgKiB0eXBlIGRpYWxvZ3MuICovCgogICAgcHJpbnRmICgiZGVsZXRl
IGV2ZW50IG9jY3VycmVkXG4iKTsKCiAgICAvKiBDaGFuZ2UgVFJVRSB0byBGQUxTRSBhbmQg
dGhlIG1haW4gd2luZG93IHdpbGwgYmUgZGVzdHJveWVkIHdpdGgKICAgICAqIGEgImRlbGV0
ZV9ldmVudCIuICovCgogICAgcmV0dXJuIFRSVUU7Cn0KCi8qIEFub3RoZXIgY2FsbGJhY2sg
Ki8Kc3RhdGljIHZvaWQgZGVzdHJveSggR3RrV2lkZ2V0ICp3aWRnZXQsCiAgICAgICAgICAg
ICAgICAgICAgIGdwb2ludGVyICAgZGF0YSApCnsKICAgIGd0a19tYWluX3F1aXQgKCk7Cn0K
CmludCBtYWluKCBpbnQgICBhcmdjLAogICAgICAgICAgY2hhciAqYXJndltdICkKewogICAg
LyogR3RrV2lkZ2V0IGlzIHRoZSBzdG9yYWdlIHR5cGUgZm9yIHdpZGdldHMgKi8KICAgIEd0
a1dpZGdldCAqd2luZG93OwogICAgR3RrV2lkZ2V0ICpidXR0b247CiAgICAKICAgIC8qIFRo
aXMgaXMgY2FsbGVkIGluIGFsbCBHVEsgYXBwbGljYXRpb25zLiBBcmd1bWVudHMgYXJlIHBh
cnNlZAogICAgICogZnJvbSB0aGUgY29tbWFuZCBsaW5lIGFuZCBhcmUgcmV0dXJuZWQgdG8g
dGhlIGFwcGxpY2F0aW9uLiAqLwogICAgZ3RrX2luaXQgKCZhcmdjLCAmYXJndik7CiAgICAK
ICAgIC8qIGNyZWF0ZSBhIG5ldyB3aW5kb3cgKi8KICAgIHdpbmRvdyA9IGd0a193aW5kb3df
bmV3IChHVEtfV0lORE9XX1RPUExFVkVMKTsKICAgIAogICAgLyogU2V0cyB0aGUgYm9yZGVy
IHdpZHRoIG9mIHRoZSB3aW5kb3cuICovCiAgICBndGtfY29udGFpbmVyX3NldF9ib3JkZXJf
d2lkdGggKChHdGtDb250YWluZXIgKil3aW5kb3csIDEwKTsKICAgIAogICAgLyogQ3JlYXRl
cyBhIG5ldyBidXR0b24gd2l0aCB0aGUgbGFiZWwgIkhlbGxvIFdvcmxkIi4gKi8KICAgIGJ1
dHRvbiA9IGd0a19idXR0b25fbmV3X3dpdGhfbGFiZWwgKCJIZWxsbyBXb3JsZCIpOwogICAg
CiAgICAvKiBUaGlzIHBhY2tzIHRoZSBidXR0b24gaW50byB0aGUgd2luZG93IChhIGd0ayBj
b250YWluZXIpLiAqLwogICAgZ3RrX2NvbnRhaW5lcl9hZGQgKChHdGtDb250YWluZXIgKil3
aW5kb3csIGJ1dHRvbik7CiAgICAKICAgIC8qIFRoZSBmaW5hbCBzdGVwIGlzIHRvIGRpc3Bs
YXkgdGhpcyBuZXdseSBjcmVhdGVkIHdpZGdldC4gKi8KICAgIGd0a193aWRnZXRfc2hvdyAo
YnV0dG9uKTsKICAgIAogICAgLyogYW5kIHRoZSB3aW5kb3cgKi8KICAgIGd0a193aWRnZXRf
c2hvdyAod2luZG93KTsKICAgIAogICAgLyogQWxsIEdUSyBhcHBsaWNhdGlvbnMgbXVzdCBo
YXZlIGEgZ3RrX21haW4oKS4gQ29udHJvbCBlbmRzIGhlcmUKICAgICAqIGFuZCB3YWl0cyBm
b3IgYW4gZXZlbnQgdG8gb2NjdXIgKGxpa2UgYSBrZXkgcHJlc3Mgb3IKICAgICAqIG1vdXNl
IGV2ZW50KS4gKi8KICAgIGd0a19tYWluICgpOwogICAgCiAgICByZXR1cm4gMDsKfQo=
--------------020503060107040505080908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
