Subject: Re: m4 synclines always 1?
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC5601045665@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55BFC56E.8090904@tycho.nsa.gov>
Date: Mon, 3 Aug 2015 15:47:58 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5601045665@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/03/2015 03:38 PM, Roberts, William C wrote:
> Are the m4 syncline’s guaranteed to start with the number 1, I can’t
> seem to come across or generate a case otherwise on Android.

Not necessarily, e.g.:

$ m4 -s
define(`foo', `1
2')
#line 2 "stdin"
