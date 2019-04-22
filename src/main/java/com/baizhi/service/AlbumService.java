package com.baizhi.service;

import com.baizhi.entity.Album;

import java.util.List;

public interface AlbumService {
    List<Album> select();

    void insert(Album album);

    List<Album> selectAll();
}
