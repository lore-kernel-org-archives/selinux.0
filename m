To: Joe Kirwin <jpk@cmd.com>, selinux@tycho.nsa.gov
Cc: Travis Szucs <ts@cmd.com>, Petr Lautrbach <plautrba@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>
References: <CAJ8tuXqjVAwfHo7usVTGKaKbhUFhUd0uZML4T3h=B=0fhmJKVg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bc31b468-299d-b0d6-af68-3f96d0655252@tycho.nsa.gov>
Date: Tue, 20 Mar 2018 11:15:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ8tuXqjVAwfHo7usVTGKaKbhUFhUd0uZML4T3h=B=0fhmJKVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Alias path subbing results in unexpected policy labelling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/19/2018 10:29 PM, Joe Kirwin wrote:
> *_Empirical Observations _*
> *
> *
> If I was to create an SELinux policy containing the following file_contexts (fruits.fc)
> ```
> /apple/orange/.*                  --              gen_context(system_u:object_r:atype_t,s0)
> /banana/.*                           --              gen_context(system_u:object_r:btype_t,s0)
> ```
> 
> If I then take the file 
> /etc/selinux/default/contexts/files/file_contexts.subs_dist and append to it the alias 
> ```
> /apple /banana
> ```
> 
> The resulting behavior is that when running:
> ```
> $ ./libselinux/utils/selabel_lookup_best_match -p /apple/orange/foo
> Best match context: system_u:object_r:btype_t:s0
> 
> But the expected behavior is to match `atype_t` as that is a "more-specific" match pattern

I don't think this is a bug based on the documented behavior for file_contexts.subs.  That said,
that support was added by Red Hat so I'll let them speak to it.

> 
> *_Looking into why_*
> 
> From the method in `libselinux/src/label_file.c` :
>                       lookup_common(struct selabel_handle *rec, const char *key, int type, bool partial) 
> 
> we encounter a call to :
>                      selabel_sub_key(struct saved_data *data, const char *key)
> 
> In the example above the candidate path we're trying to match (referred to as the key in the code) is "canonicalized" to the /banana alias but the regex being evaluated is not 
> 
> *_A proposed fix_*
> *
> *
> /Also attached (label_file.patch), if the patch formatting is off on this thread, apologies./
> *
> *
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 560d8c3..98a8d1b 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -848,7 +848,7 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>  {
>     struct saved_data *data = (struct saved_data *)rec->data;
>     struct spec *spec_arr = data->spec_arr;
> -   int i, rc, file_stem;
> +   int i, rc, file_stem, orig_file_stem;
>     mode_t mode = (mode_t)type;
>     const char *buf;
>     struct spec *ret = NULL;
> @@ -879,8 +879,12 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>     }   
>  
>     sub = selabel_sub_key(data, key);
> -   if (sub)
> +   orig_file_stem = -1; 
> +   if (sub) {
> +      orig_file_stem = find_stem_from_file(data, &key);
>         key = sub;
> +   }   
>  
>     buf = key;
>     file_stem = find_stem_from_file(data, &buf);
> @@ -896,7 +900,8 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>          * stem as the file AND if the spec in question has no mode
>          * specified or if the mode matches the file mode then we do
>          * a regex check        */  
> -       if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
> +       if ((spec->stem_id == -1 || spec->stem_id == file_stem ||  
> +            spec->stem_id == orig_file_stem) &&
>             (!mode || !spec->mode || mode == spec->mode)) {
>             if (compile_regex(data, spec, NULL) < 0)
>                 goto finish;
> 
> 
> 
> I think there is still some simplification that could be done with aliases, in that they really shouldn't have a direction (e.g. alias -> original) instead they should go both ways and if there is a tie it should go by the ordering of the specs.
> Reason for this is that a developer of an SELinux policy, may not know the contents or directionality of file_contexts.subs_dist ahead of time or when it might change.
> 
> Thanks,
> Joe Kirwin and Travis Szucs
> 
