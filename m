Message-ID: <55564BAF.6000006@tycho.nsa.gov>
Date: Fri, 15 May 2015 15:40:31 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] Fix more bin file processing core dumps
References: <5554C006.5040605@tycho.nsa.gov>
 <2128506475.602059.1431701882235.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <2128506475.602059.1431701882235.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/15/2015 10:58 AM, Richard Haines wrote:
> 
> 
> 
> 
> 
>> On Thursday, 14 May 2015, 16:35, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 05/14/2015 11:28 AM, Stephen Smalley wrote:
>>>  On 05/14/2015 10:36 AM, Richard Haines wrote:
>>>>  The reading of bin files has been changed to follow that of loading
>>>>  policy to catch over-runs. Entries that should be NULL terminated are
>>>>  also checked. If any error, then process the text file. This should
>>>>  fix all problems highlighted in [1].
>>>>
>>>>  Tested with bin files built using sefcontext_compile PCRE_VERS 1 and 2.
>>>>
>>>>  The following is a rough guide to the difference in processing a bin
>>>>  file against a text file:
>>>>     6K entries - x5
>>>>     4K entries - x4
>>>>     1K entries - x3
>>>>     500 entries - x2
>>>>
>>>>  [1] http://marc.info/?l=selinux&m=143101983922281&w=2
>>>>
>>>>  Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>>>  ---
>>>>   libselinux/src/label_file.c | 167 
>> +++++++++++++++++++++++++++-----------------
>>>>   libselinux/src/label_file.h |  20 +++++-
>>>>   2 files changed, 121 insertions(+), 66 deletions(-)
>>>>
>>>>  diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>>>>  index c722f29..d6103d8 100644
>>>>  --- a/libselinux/src/label_file.c
>>>>  +++ b/libselinux/src/label_file.c
>>>>  @@ -8,7 +8,6 @@
>>>>    * developed by Secure Computing Corporation.
>>>>    */
>>>>   
>>>>  -#include <assert.h>
>>>>   #include <fcntl.h>
>>>>   #include <stdarg.h>
>>>>   #include <string.h>
>>>>  @@ -248,9 +247,9 @@ static int load_mmap(struct selabel_handle *rec, 
>> const char *path, struct stat *
>>>>       struct mmap_area *mmap_area;
>>>>   
>>>>       uint32_t i;
>>>>  -    uint32_t *magic;
>>>>  -    uint32_t *section_len;
>>>>  -    uint32_t *plen;
>>>>  +    uint32_t magic[2];
>>>>  +    uint32_t section_len[2];
>>>>  +    uint32_t plen[2];
>>>
>>>  Why isn't this just:
>>>  uint32_t magic, section_len, plen;
>>>  and use &magic, &section_len, &plen in calls to next_entry() 
>> and magic,
>>>  section_len, and plen in place of *magic, *section_len, *plen.
>>>
>>>>  @@ -304,35 +303,36 @@ static int load_mmap(struct selabel_handle *rec, 
>> const char *path, struct stat *
>>>>       data->mmap_areas = mmap_area;
>>>>   
>>>>       /* check if this looks like an fcontext file */
>>>>  -    magic = (uint32_t *)addr;
>>>>  -    if (*magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>>>>  +    rc = next_entry(magic, mmap_area, sizeof(uint32_t));
>>>>  +    if (rc < 0 || *magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>>>>           return -1;
>>>
>>>  Then this becomes:
>>>  rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
>>>  if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>>>      return -1;
>>>
>>>  Or, alternatively, you could do it as in libsepol and declare:
>>>  uint32_t buf[2];
>>
>> Sorry, should be buf[3] in that example.
>>
>>
>>>  rc = next_entry(buf, mmap_area, sizeof buf);
>>>  and read several values at one time, e.g. the magic as buf[0], the
>>>  version as buf[1], and either the pcre version string length or the stem
> 
>>>  map length as buf[2].
> I'll fix all the problems highlighted and send a V2 next week
> 
>>>
>>>  BTW, there is no endianness conversion here, unlike libsepol for binary
>>>  policies?  So you have to ensure that you generate file_contexts.bin on
>>>  the same endian architecture as you use it?  That's a bit worrisome
>>>  although probably not an issue at the moment.  Can't change that though
>>>  without more substantial alteration and a version change, so don't 
>> worry
> 
>>>  about it for now.
> I guess this would need to be done for acceptance into Android ??. If so,
> and as the overall objective of what I started was Android support, then
> I'm willing to give this a shot by following the way libsepol handles
> this. All advice welcome.

Don't think it is a requirement.
Also not sure if file_contexts.bin might be inherently endian-specific
due to storing the compiled regex.
