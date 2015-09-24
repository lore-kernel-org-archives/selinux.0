Subject: Re: Find attributes for a type with sepol
To: James Carter <jwcart2@tycho.nsa.gov>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC5601077F23@ORSMSX103.amr.corp.intel.com>
 <5603EFE8.6010505@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5603F39A.6060607@tycho.nsa.gov>
Date: Thu, 24 Sep 2015 08:59:06 -0400
MIME-Version: 1.0
In-Reply-To: <5603EFE8.6010505@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/24/2015 08:43 AM, James Carter wrote:
> On 09/23/2015 06:39 PM, Roberts, William C wrote:
>> How would one find all the attributes of a type with libsepol, can
>> someone point me to any relevant structures or functions?
>>
> 
> The policydb_t structure has type_attr_map field which maps types to an
> ebitmap of attributes.

It also has the reverse map (attr_type_map) if you want that.

In Android, external/sepolicy/tools/sepolicy-analyze has examples of
using both maps.
