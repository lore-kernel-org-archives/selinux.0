Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8ODx48n028088
 for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2015 09:59:05 -0400
Received: by qkcf65 with SMTP id f65so29812727qkc.3
 for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2015 06:58:36 -0700 (PDT)
Message-ID: <5604018A.5030805@quarksecurity.com>
Date: Thu, 24 Sep 2015 09:58:34 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Carter <jwcart2@tycho.nsa.gov>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Find attributes for a type with sepol
References: <476DC76E7D1DF2438D32BFADF679FC5601077F23@ORSMSX103.amr.corp.intel.com>
 <5603EFE8.6010505@tycho.nsa.gov> <5603F39A.6060607@tycho.nsa.gov>
In-Reply-To: <5603F39A.6060607@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> On 09/24/2015 08:43 AM, James Carter wrote:
>> On 09/23/2015 06:39 PM, Roberts, William C wrote:
>>> How would one find all the attributes of a type with libsepol, can
>>> someone point me to any relevant structures or functions?
>>>
>> The policydb_t structure has type_attr_map field which maps types to an
>> ebitmap of attributes.
>
> It also has the reverse map (attr_type_map) if you want that.
>
> In Android, external/sepolicy/tools/sepolicy-analyze has examples of
> using both maps.
>

seinfo also knows how to do it, if you need more examples:

$ seinfo -x -tuntrusted_app sepolicy
    untrusted_app
       bluetoothdomain
       netdomain
       appdomain
       domain
