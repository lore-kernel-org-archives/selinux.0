Message-ID: <5304B3A8.9050201@tycho.nsa.gov>
Date: Wed, 19 Feb 2014 08:37:44 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: cross-labeling vs precompiled PCRE
References: <20140218212318.361DD680123@frontend2.nyi.mail.srv.osa>
 <CACLa4pu0iRVpJuWe+B01H-5CEghcWdoYsGdeSO5=V8CzrLQ01w@mail.gmail.com>
 <20140219003351.33C4A680126@frontend2.nyi.mail.srv.osa>
In-Reply-To: <20140219003351.33C4A680126@frontend2.nyi.mail.srv.osa>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/18/2014 07:28 PM, Colin Walters wrote:
> On Tue, Feb 18, 2014 at 4:45 PM, Eric Paris <eparis@parisplace.org> wrote:
>> agreed completely that a version check makes sense, but i'm pretty
>> sure I'll forget about it before I have time to look at it   :-(
>>
> I'm happy to do some implementation work here myself as well.  The
> obvious thing to do is just to stick the output of pcre_version() into
> the file - except there's no space.  So we'd need to bump the format
> version.
> 
> Now I can do that, but I think it's the kind of thing that needs a bit
> of discussion beforehand.  Any objections or further thoughts?

That's just the library version, right?  Not an indication of a format
change in the pcre regex necessarily?  Any way to get an actual version
corresponding to that format?

On the last such format change, I believe Dan et al added a trigger to
selinux-policy so that it will regenerate the .bin file on any pcre
upgrade automatically, so I guess what you describe should work, but it
would be nice if we could tie it to actual pcre regex format changes
rather than just pcre library versions.

> In the meantime though, I'm going to have to hack up my copy of
> libselinux from RHEL7 to just ignore the .bin files unconditionally.
