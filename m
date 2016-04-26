Subject: Re: trying to understand a cronie issue anno 2008
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>
References: <017f000a-3ecc-1e01-514f-a6106cfca8b9@gmail.com>
 <571F6A25.6050802@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <c71ed8f5-d036-7b49-39bb-10589620cb5a@gmail.com>
Date: Tue, 26 Apr 2016 15:40:36 +0200
MIME-Version: 1.0
In-Reply-To: <571F6A25.6050802@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/26/2016 03:16 PM, Stephen Smalley wrote:
> On 04/26/2016 07:28 AM, Dominick Grift wrote:
>> 
>> I am trying to understand an issue
>> 
>> https://bugzilla.redhat.com/show_bug.cgi?id=426704#c20
>> 
>> "Suggestion:  load_user() to pass NULL if pw is NULL, and change 
>> get_security_context() to handle a NULL name by directly calling 
>> get_default_context() on "system_u" rather than calling 
>> getseuserbyname at all. Then we don't need a system_u entry in
>> seusers."
>> 
>> Is the suggestion above about hard coding "system_u"?
> 
> No, it is about skipping the getseuserbyname() call when dealing
> with system cron jobs.  "system_u" was already hardcoded as the
> lookup key for determining the context of system cron jobs. 
> https://bugzilla.redhat.com/show_bug.cgi?id=426704#c19 explained
> the background.
> 
>> 
>> Also about:
>> 
>> "Then we don't need a system_u entry in seusers."
>> 
>> We seem to have the above anyway, even with the system_u hard
>> coded. Wondering whether it was left in for some other reason?
> 
> Not that I know of.
> 
>> Cronie refuses to run in an environment where system_u is not 
>> available when system_u is hard coded like that (i believe):
>> 
>> https://git.fedorahosted.org/cgit/cronie.git/commit/?id=e528023580984
4f5
>>
>> 
4d5956ec281472b63dcfc3f4
> 
> There are two different issues here:
> 
> 1) Requiring system_u to be mapped in the seusers configuration,
> which maps Linux usernames to SELinux users (and ranges).  This was
> what the above bug was about.  We shouldn't require a system_u
> entry in seusers because it isn't a Linux username.  It was a bug
> in vixie-cron that it was performing a getseuserbyname() call on
> "system_u"; it should have only done a get_default_context() on it
> (as in the original SELinux cron patch, before seusers was
> introduced).
> 
> 2) Requiring the system_u user to be defined in the users portion
> of the SELinux kernel policy.  That was always required by the cron
> SELinux patch in order to look up the context for system cron jobs.
> The commit you reference above appears to eliminate that as well,
> which is good, as long as it yields the right behavior.  One
> question I have is what happens if one restarts cronie manually;
> historically there have been issues with the correct user identity
> being assigned but that is probably no longer an issue with
> systemd.
> 
> 

Thank you. Since cronie is a redhat endeavor i suppose this is good
time to get rid of that remaining system_u since we now indeed have
systemd.

I will be removing the system entry from my seusers to see where that
gets me.

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXH2/PAAoJECV0jlU3+UdpepwL/1YmbF/nVHPY0Oq2NVag0Rkd
iR2FDrJh1jyuSd/2Iu7esNgBZ+ikTYO3hpdKxJJxy5Xo99qPQgpVTWe4aVKUvE41
wRVzdb29eLGMfGYkKS8lVkze52C+IIi5dX558UxVXwiFbB8wuqqT/OmRztF+9foE
i2MOc6nQSJwMeQAre1LdjS5DSeVvWW4sf+9xfDTkLTHCEO8pxCRbNybexxwmlDX0
EBt8pBa7Fzkr3zRy/FSMq4pqdj+pYqK7+oI+I9n/7HtBJ4nSx/HOULt0FOKuZlS7
JUUrOQtjfIgHygvwl4TMvlZGnf+Wp4Qynarmve4rxWej9u1dSTX+5e6984XU7G+k
/EUTqx/+gXDlnPwPWfwhpf10yGWl6wqYIhRNRKAq54hd/JHP+tejEmqliY3IZ5ll
9UJ/1l365fhmtBd6VJP8JLTr5CB2k9yiMylF/6kYNxpbTMGzKDf7pfdEME7h+ONu
vrXF604JG4QGmqC/I3YVsOwwI5gKhLuw/J4ySfZX1A==
=0X1C
-----END PGP SIGNATURE-----
