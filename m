Message-ID: <473B451D.7060205@redhat.com>
Date: Wed, 14 Nov 2007 13:57:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: Patch to allow semanage to set boolean values and	translate	booleans
 via policy.xml
References: <472B817D.3030400@redhat.com>	 <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil>	 <1194633488.5253.26.camel@gorn>  <4734B94D.3010803@redhat.com> <1194882353.13737.6.camel@gorn>
In-Reply-To: <1194882353.13737.6.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Fri, 2007-11-09 at 14:47 -0500, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Christopher J. PeBenito wrote:
>>> On Fri, 2007-11-09 at 11:25 -0500, Stephen Smalley wrote:
>>>> On Fri, 2007-11-02 at 15:58 -0400, Daniel J Walsh wrote:
>>>>> Also added translations of booleans to command line.
>>>>>
>>>>>> /usr/sbin/semanage boolean -l  | grep nfs_export
>>>>>> nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
>>>>>> nfs_export_all_ro              -> on    Allow nfs to be exported read only
>>>>>> sh-3.2# /usr/sbin/semanage boolean -l  | grep nfs
>>>>>> xen_use_nfs                    -> off   Allow xen to manage nfs files
>>> [...]
>>>>>> nfs_export_all_ro              -> on    Allow nfs to be exported read only
>>>>> This time with the patch.  :^)
>>>> Offhand, the only problem I see it that semanage boolean -l then fails
>>>> if /usr/share/selinux/devel/policy.xml doesn't exist, rather than just
>>>> falling back to displaying the untranslated booleans.
>>>>
>>>> Also, is /usr/share/selinux/devel/policy.xml created by upstream
>>>> refpolicy or is it Fedora-specific?
>>> The infrastructure for building a policy.xml from the headers is
>>> installed by upstream, but the policy.xml from refpolicy is not
>>> installed.  This allows 3rd parties to add their headers and then a
>>> policy.xml can be built to include their module.  Installing a
>>> policy.xml there is a fedora-specific thing.
>>>
>> If I want to rebuild it after an interface file gets installed or want
>> to add my own xml to it, what do I need to do?
> 
> The 'xml' target from the headers makefile will build one.  It uses the
> xml in header if files, plus global_(booleans|tunables).xml which are
> pre generated from the global_(booleans|tunables) in the source policy.
> 
I am not sure how you intend this to work.

Currently we ship policy.xml and the xml files for each *if file.  We do
not ship the xml files for each directory admin.xml, apps.xdl, services.xml

I would have thought the third party would ship there own xml and if
file say myapp.if and myapp.xml.  Install them in
/usr/share/selinux/devel/include/services.

Then they would execute make -f /usr/share/selinux/devel/Makefile xml

And it would rebuild the policy.xml including their changes.

Is this what you are thinking?

Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHO0UdrlYvE4MpobMRAlYJAJ99NXipSygr5iNhSQdJWVlBKTi6pwCfeoIm
XdUxyvk9nHynq/UVDpXMKAg=
=yXWp
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
