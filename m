Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A27ECE58E
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 09:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B092083B
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 09:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfJOJeo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:34:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJeo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 15 Oct 2019 05:34:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6D3BC049E1A;
        Tue, 15 Oct 2019 09:34:43 +0000 (UTC)
Received: from localhost (unknown [10.34.245.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B0745D6A9;
        Tue, 15 Oct 2019 09:34:40 +0000 (UTC)
References: <20191013105216.614224-1-nicolas.iooss@m4x.org> <20191013105216.614224-2-nicolas.iooss@m4x.org>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org, Michael Shigorin <mike@altlinux.org>
Subject: Re: [PATCH 2/2] libsemanage: mark all exported function "extern"
In-reply-to: <20191013105216.614224-2-nicolas.iooss@m4x.org>
Date:   Tue, 15 Oct 2019 11:34:35 +0200
Message-ID: <pjd7e564aj8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 15 Oct 2019 09:34:44 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Many functions are already marked "extern" in libsemanage's public
> headers and this will help using the content of the headers in order to
> automatically generate some glue code for Python bindings.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Do you plan to provide a test which would guard libselinux.h and
libsemanage.h so that all new functions are added with extern?

Anyway, for both

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  libsemanage/include/semanage/handle.h  |  58 ++++-----
>  libsemanage/include/semanage/modules.h | 158 ++++++++++++-------------
>  2 files changed, 108 insertions(+), 108 deletions(-)
>
> diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
> index c816590094c5..946d69bc91fe 100644
> --- a/libsemanage/include/semanage/handle.h
> +++ b/libsemanage/include/semanage/handle.h
> @@ -32,13 +32,13 @@ typedef struct semanage_handle semanage_handle_t;
>  
>  /* Create and return a semanage handle.
>     The handle is initially in the disconnected state. */
> -semanage_handle_t *semanage_handle_create(void);
> +extern semanage_handle_t *semanage_handle_create(void);
>  
>  /* Deallocate all space associated with a semanage_handle_t, including
>   * the pointer itself.	CAUTION: this function does not disconnect
>   * from the backend; be sure that a semanage_disconnect() was
>   * previously called if the handle was connected. */
> -void semanage_handle_destroy(semanage_handle_t *);
> +extern void semanage_handle_destroy(semanage_handle_t *);
>  
>  /* This is the type of connection to the store, for now only
>   * direct is supported */
> @@ -51,65 +51,65 @@ enum semanage_connect_type {
>   * It must be called after semanage_handle_create but before 
>   * semanage_connect. The argument should be the full path to the store.
>   */
> -void semanage_select_store(semanage_handle_t * handle, char *path,
> -			   enum semanage_connect_type storetype);
> +extern void semanage_select_store(semanage_handle_t * handle, char *path,
> +				  enum semanage_connect_type storetype);
>  
>  /* Just reload the policy */
> -int semanage_reload_policy(semanage_handle_t * handle);
> +extern int semanage_reload_policy(semanage_handle_t * handle);
>  
>  /* set whether to reload the policy or not after a commit,
>   * 1 for yes (default), 0 for no */
> -void semanage_set_reload(semanage_handle_t * handle, int do_reload);
> +extern void semanage_set_reload(semanage_handle_t * handle, int do_reload);
>  
>  /* set whether to rebuild the policy on commit, even if no
>   * changes were performed.
>   * 1 for yes, 0 for no (default) */
> -void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
> +extern void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
>  
>  /* Fills *compiler_path with the location of the hll compiler sh->conf->compiler_directory_path
>   * corresponding to lang_ext.
>   * Upon success returns 0, -1 on error. */
> -int semanage_get_hll_compiler_path(semanage_handle_t *sh, char *lang_ext, char **compiler_path);
> +extern int semanage_get_hll_compiler_path(semanage_handle_t *sh, char *lang_ext, char **compiler_path);
>  
>  /* create the store if it does not exist, this only has an effect on 
>   * direct connections and must be called before semanage_connect 
>   * 1 for yes, 0 for no (default) */
> -void semanage_set_create_store(semanage_handle_t * handle, int create_store);
> +extern void semanage_set_create_store(semanage_handle_t * handle, int create_store);
>  
>  /*Get whether or not dontaudits will be disabled upon commit */
> -int semanage_get_disable_dontaudit(semanage_handle_t * handle);
> +extern int semanage_get_disable_dontaudit(semanage_handle_t * handle);
>  
>  /* Set whether or not to disable dontaudits upon commit */
> -void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
> +extern void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
>  
>  /* Set whether or not to execute setfiles to check file contexts upon commit */
> -void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts);
> +extern void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts);
>  
>  /* Get the default priority. */
> -uint16_t semanage_get_default_priority(semanage_handle_t *sh);
> +extern uint16_t semanage_get_default_priority(semanage_handle_t *sh);
>  
>  /* Set the default priority. */
> -int semanage_set_default_priority(semanage_handle_t *sh, uint16_t priority);
> +extern int semanage_set_default_priority(semanage_handle_t *sh, uint16_t priority);
>  
>  /* Check whether policy is managed via libsemanage on this system.
>   * Must be called prior to trying to connect.
>   * Return 1 if policy is managed via libsemanage on this system,
>   * 0 if policy is not managed, or -1 on error.
>   */
> -int semanage_is_managed(semanage_handle_t *);
> +extern int semanage_is_managed(semanage_handle_t *);
>  
>  /* "Connect" to a manager based on the configuration and 
>   * associate the provided handle with the connection.
>   * If the connect fails then this function returns a negative value, 
>   * else it returns zero.
>   */
> -int semanage_connect(semanage_handle_t *);
> +extern int semanage_connect(semanage_handle_t *);
>  
>  /* Disconnect from the manager given by the handle.  If already
>   * disconnected then this function does nothing.  Return 0 if
>   * disconnected properly or already disconnected, negative value on
>   * error. */
> -int semanage_disconnect(semanage_handle_t *);
> +extern int semanage_disconnect(semanage_handle_t *);
>  
>  /* Attempt to obtain a transaction lock on the manager.	 If another
>   * process has the lock then this function may block, depending upon
> @@ -118,47 +118,47 @@ int semanage_disconnect(semanage_handle_t *);
>   * Note that if the semanage_handle has not yet obtained a transaction
>   * lock whenever a writer function is called, there will be an
>   * implicit call to this function. */
> -int semanage_begin_transaction(semanage_handle_t *);
> +extern int semanage_begin_transaction(semanage_handle_t *);
>  
>  /* Attempt to commit all changes since this transaction began.	If the
>   * commit is successful then increment the "policy sequence number"
>   * and then release the transaction lock.  Return that policy number
>   * afterwards, or -1 on error.
>   */
> -int semanage_commit(semanage_handle_t *);
> +extern int semanage_commit(semanage_handle_t *);
>  
>  #define SEMANAGE_CAN_READ 1
>  #define SEMANAGE_CAN_WRITE 2
>  /* returns SEMANAGE_CAN_READ or SEMANAGE_CAN_WRITE if the store is readable
>   * or writable, respectively. <0 if an error occurred */
> -int semanage_access_check(semanage_handle_t * sh);
> +extern int semanage_access_check(semanage_handle_t * sh);
>  
>  /* returns 0 if not connected, 1 if connected */
> -int semanage_is_connected(semanage_handle_t * sh);
> +extern int semanage_is_connected(semanage_handle_t * sh);
>  
>  /* returns 1 if policy is MLS, 0 otherwise. */
> -int semanage_mls_enabled(semanage_handle_t *sh);
> +extern int semanage_mls_enabled(semanage_handle_t *sh);
>  
>  /* Change to alternate semanage root path */
> -int semanage_set_root(const char *path);
> +extern int semanage_set_root(const char *path);
>  
>  /* Get the current semanage root path */
> -const char * semanage_root(void);
> +extern const char * semanage_root(void);
>  
>  /* Get whether or not needless unused branch of tunables would be preserved */
> -int semanage_get_preserve_tunables(semanage_handle_t * handle);
> +extern int semanage_get_preserve_tunables(semanage_handle_t * handle);
>  
>  /* Set whether or not to preserve the needless unused branch of tunables */
> -void semanage_set_preserve_tunables(semanage_handle_t * handle, int preserve_tunables);
> +extern void semanage_set_preserve_tunables(semanage_handle_t * handle, int preserve_tunables);
>  
>  /* Get the flag value for whether or not caching is ignored for compiled CIL modules from HLL files */
> -int semanage_get_ignore_module_cache(semanage_handle_t *handle);
> +extern int semanage_get_ignore_module_cache(semanage_handle_t *handle);
>  
>  /* Set semanage_handle flag for whether or not to ignore caching of compiled CIL modules from HLL files */
> -void semanage_set_ignore_module_cache(semanage_handle_t *handle, int ignore_module_cache);
> +extern void semanage_set_ignore_module_cache(semanage_handle_t *handle, int ignore_module_cache);
>  
>  /* set the store root path for semanage output files */
> -void semanage_set_store_root(semanage_handle_t *sh, const char *store_root);
> +extern void semanage_set_store_root(semanage_handle_t *sh, const char *store_root);
>  
>  /* META NOTES
>   *
> diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
> index 03f7e57d50dd..ac4039314857 100644
> --- a/libsemanage/include/semanage/modules.h
> +++ b/libsemanage/include/semanage/modules.h
> @@ -32,11 +32,11 @@ typedef struct semanage_module_key semanage_module_key_t;
>   * a transaction  
>   */
>  
> -int semanage_module_install(semanage_handle_t *,
> -			    char *module_data, size_t data_len, char *name, char *ext_lang);
> -int semanage_module_install_file(semanage_handle_t *,
> -				 const char *module_name);
> -int semanage_module_remove(semanage_handle_t *, char *module_name);
> +extern int semanage_module_install(semanage_handle_t *,
> +				   char *module_data, size_t data_len, char *name, char *ext_lang);
> +extern int semanage_module_install_file(semanage_handle_t *,
> +					const char *module_name);
> +extern int semanage_module_remove(semanage_handle_t *, char *module_name);
>  
>  /* semanage_module_info is for getting information on installed
>     modules, only name at this time */
> @@ -52,18 +52,18 @@ typedef struct semanage_module_info semanage_module_info_t;
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_extract(semanage_handle_t *sh,
> -				 semanage_module_key_t *modkey,
> -				 int extract_cil,
> -				 void **mapped_data,
> -				 size_t *data_len,
> -				 semanage_module_info_t **modinfo);
> -int semanage_module_list(semanage_handle_t *,
> -			 semanage_module_info_t **, int *num_modules);
> -void semanage_module_info_datum_destroy(semanage_module_info_t *);
> -semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t * list,
> -						 int n);
> -const char *semanage_module_get_name(semanage_module_info_t *);
> +extern int semanage_module_extract(semanage_handle_t *sh,
> +				  semanage_module_key_t *modkey,
> +				  int extract_cil,
> +				  void **mapped_data,
> +				  size_t *data_len,
> +				  semanage_module_info_t **modinfo);
> +extern int semanage_module_list(semanage_handle_t *,
> +				semanage_module_info_t **, int *num_modules);
> +extern void semanage_module_info_datum_destroy(semanage_module_info_t *);
> +extern semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t * list,
> +							int n);
> +extern const char *semanage_module_get_name(semanage_module_info_t *);
>  
>  /* Module Info */
>  
> @@ -74,8 +74,8 @@ const char *semanage_module_get_name(semanage_module_info_t *);
>   * The @modinfo should be destroyed with semanage_module_info_destroy.
>   * The caller should call free() on the struct.
>   */
> -int semanage_module_info_create(semanage_handle_t *sh,
> -				semanage_module_info_t **modinfo);
> +extern int semanage_module_info_create(semanage_handle_t *sh,
> +				       semanage_module_info_t **modinfo);
>  
>  /* Frees the members of the module info struct.
>   *
> @@ -83,8 +83,8 @@ int semanage_module_info_create(semanage_handle_t *sh,
>   *
>   * The caller should call free() on the struct.
>   */
> -int semanage_module_info_destroy(semanage_handle_t *handle,
> -				 semanage_module_info_t *modinfo);
> +extern int semanage_module_info_destroy(semanage_handle_t *handle,
> +					semanage_module_info_t *modinfo);
>  
>  /* Module Info Getters */
>  
> @@ -92,33 +92,33 @@ int semanage_module_info_destroy(semanage_handle_t *handle,
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_get_priority(semanage_handle_t *sh,
> -				      semanage_module_info_t *modinfo,
> -				      uint16_t *priority);
> +extern int semanage_module_info_get_priority(semanage_handle_t *sh,
> +					     semanage_module_info_t *modinfo,
> +					     uint16_t *priority);
>  
>  /* Get @name from @modinfo. Caller should not free @name.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_get_name(semanage_handle_t *sh,
> -				  semanage_module_info_t *modinfo,
> -				  const char **name);
> +extern int semanage_module_info_get_name(semanage_handle_t *sh,
> +					 semanage_module_info_t *modinfo,
> +					 const char **name);
>  
>  /* Get @lang_ext from @modinfo. Caller should not free @lang_ext.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
> -				      semanage_module_info_t *modinfo,
> -				      const char **lang_ext);
> +extern int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
> +					     semanage_module_info_t *modinfo,
> +					     const char **lang_ext);
>  
>  /* Get @enabled from @modinfo.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_get_enabled(semanage_handle_t *sh,
> -				     semanage_module_info_t *modinfo,
> -				     int *enabled);
> +extern int semanage_module_info_get_enabled(semanage_handle_t *sh,
> +					    semanage_module_info_t *modinfo,
> +					    int *enabled);
>  
>  /* Module Info Setters */
>  
> @@ -126,33 +126,33 @@ int semanage_module_info_get_enabled(semanage_handle_t *sh,
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_set_priority(semanage_handle_t *sh,
> -				      semanage_module_info_t *modinfo,
> -				      uint16_t priority);
> +extern int semanage_module_info_set_priority(semanage_handle_t *sh,
> +					     semanage_module_info_t *modinfo,
> +					     uint16_t priority);
>  
>  /* Set @name in @modinfo.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_set_name(semanage_handle_t *sh,
> -				  semanage_module_info_t *modinfo,
> -				  const char *name);
> +extern int semanage_module_info_set_name(semanage_handle_t *sh,
> +					 semanage_module_info_t *modinfo,
> +					 const char *name);
>  
>  /* Set @lang_ext in @modinfo.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
> -				      semanage_module_info_t *modinfo,
> -				      const char *lang_ext);
> +extern int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
> +					     semanage_module_info_t *modinfo,
> +					     const char *lang_ext);
>  
>  /* Set @enabled in @modinfo.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_info_set_enabled(semanage_handle_t *sh,
> -				     semanage_module_info_t *modinfo,
> -				     int enabled);
> +extern int semanage_module_info_set_enabled(semanage_handle_t *sh,
> +					    semanage_module_info_t *modinfo,
> +					    int enabled);
>  
>  /* Module Key */
>  
> @@ -163,16 +163,16 @@ int semanage_module_info_set_enabled(semanage_handle_t *sh,
>   * The @modkey should be destroyed with semanage_module_key_destroy.
>   * The caller should call free() on the struct.
>   */
> -int semanage_module_key_create(semanage_handle_t *sh,
> -			       semanage_module_key_t **modkey);
> +extern int semanage_module_key_create(semanage_handle_t *sh,
> +				      semanage_module_key_t **modkey);
>  
>  /* Frees members of the @modkey, but not the struct. The caller should
>   * call free() on struct.
>   *
>   * Returns 0 on success, and -1 on error.
>   */
> -int semanage_module_key_destroy(semanage_handle_t *sh,
> -				semanage_module_key_t *modkey);
> +extern int semanage_module_key_destroy(semanage_handle_t *sh,
> +				       semanage_module_key_t *modkey);
>  
>  /* Module Key Getters */
>  
> @@ -180,17 +180,17 @@ int semanage_module_key_destroy(semanage_handle_t *sh,
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_key_get_name(semanage_handle_t *sh,
> -				 semanage_module_key_t *modkey,
> -				 const char **name);
> +extern int semanage_module_key_get_name(semanage_handle_t *sh,
> +					semanage_module_key_t *modkey,
> +					const char **name);
>  
>  /* Get @name from @modkey.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_key_get_priority(semanage_handle_t *sh,
> -				     semanage_module_key_t *modkey,
> -				     uint16_t *priority);
> +extern int semanage_module_key_get_priority(semanage_handle_t *sh,
> +					    semanage_module_key_t *modkey,
> +					    uint16_t *priority);
>  
>  /* Module Key Setters */
>  
> @@ -198,17 +198,17 @@ int semanage_module_key_get_priority(semanage_handle_t *sh,
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_key_set_name(semanage_handle_t *sh,
> -				 semanage_module_key_t *modkey,
> -				 const char *name);
> +extern int semanage_module_key_set_name(semanage_handle_t *sh,
> +					semanage_module_key_t *modkey,
> +					const char *name);
>  
>  /* Set @priority in @modkey.
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_key_set_priority(semanage_handle_t *sh,
> -				     semanage_module_key_t *modkey,
> -				     uint16_t priority);
> +extern int semanage_module_key_set_priority(semanage_handle_t *sh,
> +					    semanage_module_key_t *modkey,
> +					    uint16_t priority);
>  
>  /* Set module @enabled status from @modkey. Modules are enabled on a per
>   * module name basis (across all priorities). @modkey only needs to have
> @@ -216,18 +216,18 @@ int semanage_module_key_set_priority(semanage_handle_t *sh,
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_set_enabled(semanage_handle_t *sh,
> -				const semanage_module_key_t *modkey,
> -				int enabled);
> +extern int semanage_module_set_enabled(semanage_handle_t *sh,
> +				       const semanage_module_key_t *modkey,
> +				       int enabled);
>  
>  /* Lookup @modinfo by @modkey. Caller should use
>   * semanage_module_info_destroy and free on @modinfo.
>   * 
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_get_module_info(semanage_handle_t *sh,
> -				    const semanage_module_key_t *modkey,
> -				    semanage_module_info_t **modinfo);
> +extern int semanage_module_get_module_info(semanage_handle_t *sh,
> +					   const semanage_module_key_t *modkey,
> +					   semanage_module_info_t **modinfo);
>  
>  /* Create a list of all modules in @modinfos of length @modinfos_len.
>   * The list will be sorted from high priority to low and alphabetically
> @@ -238,9 +238,9 @@ int semanage_module_get_module_info(semanage_handle_t *sh,
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_list_all(semanage_handle_t *sh,
> -			     semanage_module_info_t **modinfos,
> -			     int *modinfos_len);
> +extern int semanage_module_list_all(semanage_handle_t *sh,
> +				    semanage_module_info_t **modinfos,
> +				    int *modinfos_len);
>  
>  /* Install the module indicated by @modinfo with input data from 
>   * @module_data with length @data_len.
> @@ -254,10 +254,10 @@ int semanage_module_list_all(semanage_handle_t *sh,
>   *	-2	failure, invalid @modinfo
>   *	-3	failure, error writing file
>   */
> -int semanage_module_install_info(semanage_handle_t *sh,
> -				 const semanage_module_info_t *modinfo,
> -				 char *data,
> -				 size_t data_len);
> +extern int semanage_module_install_info(semanage_handle_t *sh,
> +					const semanage_module_info_t *modinfo,
> +					char *data,
> +					size_t data_len);
>  
>  /* Remove the module indicated by @modkey.
>   * @modkey must have key values filled in.
> @@ -267,8 +267,8 @@ int semanage_module_install_info(semanage_handle_t *sh,
>   *	-1	failure, out of memory
>   *	-2	failure, @module not found or couldn't be removed
>   */
> -int semanage_module_remove_key(semanage_handle_t *sh,
> -			       const semanage_module_key_t *modkey);
> +extern int semanage_module_remove_key(semanage_handle_t *sh,
> +				      const semanage_module_key_t *modkey);
>  
>  /* Module Enabled */
>  
> @@ -278,8 +278,8 @@ int semanage_module_remove_key(semanage_handle_t *sh,
>   *
>   * Returns 0 on success and -1 on error.
>   */
> -int semanage_module_get_enabled(semanage_handle_t *sh,
> -				const semanage_module_key_t *modkey,
> -				int *enabled);
> +extern int semanage_module_get_enabled(semanage_handle_t *sh,
> +				       const semanage_module_key_t *modkey,
> +				       int *enabled);
>  
>  #endif


-- 
()  ascii ribbon campaign - against html e-mail 
/\  www.asciiribbon.org   - against proprietary attachments
