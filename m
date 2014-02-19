Date: Wed, 19 Feb 2014 15:02:42 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: cross-labeling vs precompiled PCRE
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <5304B3A8.9050201@tycho.nsa.gov>
References: <20140218212318.361DD680123@frontend2.nyi.mail.srv.osa>
 <CACLa4pu0iRVpJuWe+B01H-5CEghcWdoYsGdeSO5=V8CzrLQ01w@mail.gmail.com>
 <20140219003351.33C4A680126@frontend2.nyi.mail.srv.osa>
 <5304B3A8.9050201@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-apmwtpWOu54E30pOjROe"
Message-Id: <20140219150745.9F51E6801B5@frontend2.nyi.mail.srv.osa>
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-apmwtpWOu54E30pOjROe
Content-Type: text/plain; charset=utf-8; format=flowed

On Wed, Feb 19, 2014 at 8:37 AM, Stephen Smalley <sds@tycho.nsa.gov> 
wrote:
> 
> That's just the library version, right?  Not an indication of a format
> change in the pcre regex necessarily?  
> 

Right. 

> Any way to get an actual version
> corresponding to that format?
> 

Unfortunately not.  The docs say (from "man pcreprecompile"):

COMPATIBILITY WITH DIFFERENT PCRE RELEASES

       In general, it is safest to recompile all saved patterns when 
you update to a new PCRE release, though not all updates actually 
require this.

> On the last such format change, I believe Dan et al added a trigger to
> selinux-policy so that it will regenerate the .bin file on any pcre
> upgrade automatically, so I guess what you describe should work, but 
> it
> would be nice if we could tie it to actual pcre regex format changes
> rather than just pcre library versions.
> 
Would require new PCRE API, and more importantly long term buy-in from 
upstream to maintain that version when the implementation details 
change in an incompatible way.

It sounds like the RPM trigger will work for the normal case of 
labeling inside a running system, it's just me who's being bitten by my 
"cross labeling" approach.

For now I just have a locally patched copy of libselinux that skips 
loading the .bin file, I'll just keep that for now and come back to 
this later.

(Although now that I look at it again, I could probably just 
temporarily set the mtime on the regular file to be later than the .bin)



--=-apmwtpWOu54E30pOjROe
Content-Type: text/html; charset=utf-8

On Wed, Feb 19, 2014 at 8:37 AM, Stephen Smalley &lt;sds@tycho.nsa.gov&gt; wrote:<br>
<blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;">
That's just the library version, right?  Not an indication of a format
change in the pcre regex necessarily?  </div></blockquote><div><br></div><div>Right.&nbsp;</div><br><blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;">Any way to get an actual version
corresponding to that format?</div></blockquote><div><br></div><div>Unfortunately not. &nbsp;The docs say (from "man pcreprecompile"):</div><div><br></div><div>COMPATIBILITY WITH DIFFERENT PCRE RELEASES</div><div><br></div><div>&nbsp; &nbsp; &nbsp; &nbsp;In general, it is safest to recompile all saved patterns when you update to a new PCRE release, though not all updates actually require this.</div><div><br></div><blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;">On the last such format change, I believe Dan et al added a trigger to
selinux-policy so that it will regenerate the .bin file on any pcre
upgrade automatically, so I guess what you describe should work, but it
would be nice if we could tie it to actual pcre regex format changes
rather than just pcre library versions.</div></blockquote><br><div>Would require new PCRE API, and more importantly long term buy-in from upstream to maintain that version when the implementation details change in an incompatible way.</div><div><br></div><div>It sounds like the RPM trigger will work for the normal case of labeling inside a running system, it's just me who's being bitten by my "cross labeling" approach.</div><div><br></div><div>For now I just have a locally patched copy of libselinux that skips loading the .bin file, I'll just keep that for now and come back to this later.</div><div><br></div><div>(Although now that I look at it again, I could probably just temporarily set the mtime on the regular file to be later than the .bin)</div><div><br></div>
--=-apmwtpWOu54E30pOjROe--
