Message-ID: <46E98E93.40206@redhat.com>
Date: Thu, 13 Sep 2007 15:25:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <1189537981.3407.51.camel@localhost.localdomain>	 <46E6FB25.5070507@redhat.com>	 <1189545987.4823.6.camel@localhost.localdomain>	 <1189692512.18713.61.camel@moss-spartans.epoch.ncsc.mil>	 <1189694812.3538.20.camel@localhost.localdomain> <1189695443.18713.95.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1189695443.18713.95.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Thu, 2007-09-13 at 10:46 -0400, Karl MacMillan wrote:
>> On Thu, 2007-09-13 at 10:08 -0400, Stephen Smalley wrote:
>>> On Tue, 2007-09-11 at 17:26 -0400, Karl MacMillan wrote:
>>>> On Tue, 2007-09-11 at 16:31 -0400, Daniel J Walsh wrote:
>>>> [...]
>>>>> One other feature/requirement would be to not override dontaudit rules.
>>>>> So if I have a domain in permissive mode and I have a dontaudit rule  on
>>>>> reading /etc/shadow.  The app should still be denied reading
>>>>> /etc/shadow.  (This is not a show stopper, but would allow us to force
>>>>> apps to take the code paths they will take in enforcing mode.)
>>>> This isn't specific to per-domain permissive, right? It would be useful
>>>> in general for permissive.
>>> I would be opposed to such a change, as it is a semantic change to what
>>> dontaudit means.
>>>
>>> Keep in mind that allow, auditallow, and dontaudit/auditdeny are all
>>> independent of one another today and none of them imply the other, e.g.
>>> 	allow a b:file read;
>>> 	auditallow a b:file *;
>>> 	dontaudit a b:file *;
>>> is perfectly valid and means:
>>> - Let a read files labeled b,
>>> - Audit all permission grantings from a to files labeled b,
>>> - Don't audit any permission denials from a to files labeled b.
>>>
>> I agree that changing the dontaudit semantic has problems - however the
>> reason Dan suggested is still valid. Currently, generating policy in
>> permissive mode can lead to bogus or overly permissive policy. It would
>> be nice to have some solution to that problem.
> 
> Can't you handle that in the tool, by giving matching interfaces with
> dontaudit rules precedence over ones with allow rules and asking the
> user?
> 
> I'd actually rather see an improved capability for (more easily)
> generating policy incrementally in enforcing mode.  That would make it
> more suitable for production use and avoid the problem above.
> 
Said large financial institution rols out policy for managing huge money
transactions in permissive mode.   Policy build with a pam for verifying
users.

Users selected app_uses_pam in policy design tool.

Tool adds

dontaudit financeapp_t shadow_t:file r_file_perms;

App in permissive mode reads shadow perms.  Dontaudit covers it up.

App runs for three months.  policy writer sees no avc messages for a
long time,  Thinks everything is fine.

Turns on enforcing mode, app tries to authenticate on mysql, gets
denials apps blow up, millions lost, people say selinux sucks, policy
writer is fired.

If I want the current behavior to see full permissive mode, I can
semodule -DB or build my policy without dontaudit.

permissive mode not following code path of dontaudit would causes major
problems.


fired.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG6Y6TrlYvE4MpobMRAgbeAJ9xunutSHL4xFXLEW8NznOnt0FjDgCdFo8s
py7sQ0X7vnGeGSp9GIHr+7E=
=io/Y
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
